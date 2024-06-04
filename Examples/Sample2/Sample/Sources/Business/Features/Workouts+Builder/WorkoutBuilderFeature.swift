//
//  WorkoutBuilderFeature.swift
//  FeatureWorkoutBuilder
//
//  Created by Filip Božić on 2. 04. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation
import ComposableArchitecture
import CommonTca
import CommonModels

@Reducer
public struct WorkoutBuilderRootFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var builder: WorkoutBuilderFeature.State
        var rootExercise: RepsExercise
        @Shared(.workouts) var builtExercises: [RepsExercise] = []
        
        public init(exercise: RepsExercise) {
            self.rootExercise = exercise
            self.builder = .init(exercise: exercise)
        }
    }
    
    public enum Action: Equatable {
        public enum DelegateAction: Equatable {
            case dismiss
        }
        
        @CasePathable
        public enum ViewAction: Equatable {
            case onWorkoutRename(String)
        }
        
        case builder(WorkoutBuilderFeature.Action)
        case delegate(DelegateAction)
        case view(ViewAction)
    }
    
    public var body: some ReducerOf<Self> {
        CombineReducers {
            Reduce { state, action in
                switch action {
                case .builder(let action):
                    switch action {
                    case .view:
                        return .none
                        
                    case .business:
                        return .none
                        
                    case .delegate(let delegateAction):
                        switch delegateAction {
                        case .onSave:
                            state.rootExercise.subExercises = mapStateToExerciseArray(state.builder.exercises)
                            state.builtExercises.insert(state.rootExercise, at: 0)
                            return .send(.delegate(.dismiss))
                        }
                    }
                    
                case .view(let action):
                    switch action {
                    case .onWorkoutRename(let name):
                        state.rootExercise.name = name
                        state.builder.exercise.name = name
                        return .none
                    }
                default:
                    return .none
                }
            }
            
            Scope(state: \.builder, action: \.builder) {
                WorkoutBuilderFeature()
            }
        }
    }
    
    /// Maps array of State to array of RepsExercise. Every state has an exercise. Function is called recursively until every child is added to its parent
    /// - Parameters:
    ///   - states: Array of WorkoutBuilderFeature.State
    /// - Returns: Array of RepsExercise
    func mapStateToExerciseArray(_ states: IdentifiedArrayOf<WorkoutBuilderFeature.State>) -> [RepsExercise] {
        return states.map { state in
            var exercise = state.exercise
            if !state.exercises.isEmpty {
                exercise.subExercises = mapStateToExerciseArray(state.exercises)
            }
            
            return exercise
        }
    }
}

@Reducer
public struct WorkoutBuilderFeature: Reducer {
    
    @ObservableState
    public struct State: Equatable, Identifiable {
        
        public var exercise: RepsExercise
        public var exercises = IdentifiedArrayOf<WorkoutBuilderFeature.State>()
        public var duration: String
        public var media: String?
        public var id: UUID = UUID()
        
        public init(exercise: RepsExercise) {
            self.exercise = exercise
            self.duration = BuilderHelper.millisecondsToDurationString(exercise.durationInMillis ?? 0.0)
            self.media = exercise.media?.url?.lastPathComponent
        }
    }
    
    public enum Action: TCAFeatureAction, Equatable {
        
        @CasePathable
        public enum ViewAction: Equatable {
            case onAddExercise(RepsExercise)
            case onDelete(IndexSet)
            case onNameChange(String)
            case onExerciseTypeChange(ExerciseType)
            case onExerciseCyclesChange(Int)
            case onExerciseRepsChange(Int?)
            case onExerciseLoopChange(Bool)
            case onExerciseCanSkipChange(Bool)
            case onExerciseTimeIntervalChange(String)
            case onExerciseMediaChange(String?)
            case onSave
        }
        
        public enum DelegateAction: Equatable {
            case onSave
        }
        
        @CasePathable
        public enum BusinessAction: Equatable {
            indirect case subExerciseList(IdentifiedActionOf<WorkoutBuilderFeature>)
        }
        
        case view(ViewAction)
        case delegate(DelegateAction)
        case business(BusinessAction)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return _reduce(into: &state, action: action)
                
            case let .delegate(action):
                return _reduce(into: &state, action: action)
                
            case let .business(action):
                return _reduce(into: &state, action: action)
            }
        }
        .forEach(\.exercises, action: \.business.subExerciseList) {
            Self()
        }
    }
    
    private func _reduce(into state: inout State, action: Action.ViewAction) -> Effect<Action> {
        switch action {
        case .onAddExercise(let exercise):
            state.exercises.insert(State(exercise: exercise), at: 0)
            return .none
        case .onDelete(let indexSet):
            state.exercises.remove(atOffsets: indexSet)
            return .none
            
        case .onNameChange(let name):
            state.exercise.name = name
            return .none
            
        case .onExerciseTypeChange(let type):
            state.exercise.type = type
            return .none
            
        case .onExerciseCyclesChange(let cycles):
            state.exercise.exerciseRepetition = cycles
            return .none
            
        case .onExerciseRepsChange(let reps):
            state.exercise.reps = reps
            return .none
            
        case .onExerciseLoopChange(let loop):
            state.exercise.loopSubExercises = loop
            return .none
            
        case .onExerciseCanSkipChange(let canSkip):
            state.exercise.canSkipExercise = canSkip
            return .none
            
        case .onExerciseTimeIntervalChange(let duration):
            state.exercise.durationInMillis = durationStringToMilliseconds(duration)
            state.duration = duration
            return .none
            
        case .onExerciseMediaChange(let media):
            state.media = media
            state.exercise.media = DummyData().emilyVideos.first(where: { $0.url?.lastPathComponent == media })
            return .none
            
        case .onSave:
            return .send(.delegate(.onSave))
        }
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
        switch action {
            
        // MARK: - Children - Delegate methods
        case let .subExerciseList(.element(_, .delegate(delegateAction))):
            switch delegateAction {
            case .onSave:
                return .send(.delegate(.onSave))
            }
            
        case .subExerciseList:
            return .none
        }
    }
    
    private func durationStringToMilliseconds(_ durationString: String) -> Double? {
        let components = durationString.components(separatedBy: ":")
        guard components.count == 2,
              let minutes = Double(components[0]),
              let seconds = Double(components[1]) else {
            return nil
        }
        return (minutes * 60 + seconds) * 1000
    }
}

private struct BuilderHelper {
    static func millisecondsToDurationString(_ milliseconds: Double) -> String {
        Duration.milliseconds(milliseconds).formatted(.time(pattern: .minuteSecond))
    }
}
