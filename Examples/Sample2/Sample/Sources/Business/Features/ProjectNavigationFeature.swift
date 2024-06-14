//
//  ProjectNavigationFeature.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 23. 02. 24.
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
struct ProjectNavigationFeature: Reducer {
    private let media = DummyData().emilyVideos
    struct State: Equatable {
        var root: Root.State
        var path: StackState<Path.State>
        
        init(root: Root.State, path: StackState<Path.State> = StackState<Path.State>()) {
            self.root = root
            self.path = path
        }
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction {
            case path(StackAction<Path.State, Path.Action>)
            case root(Root.Action)
        }
        
        enum DelegateAction: Equatable {
            case closeFlow
        }
        
        enum BusinessAction: Equatable {
            
        }
        
        case view(ViewAction)
        case delegate(DelegateAction)
        case business(BusinessAction)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return _reduce(into: &state, action: action)
                
            case let .delegate(action):
                return _reduce(into: &state, action: action)
                
            case let .business(action):
                return _reduce(into: &state, action: action)
            }
        }.forEach(\.path, action: \.view.path)
        
    }
    
    private func _reduce(into state: inout State, action: Action.ViewAction) -> Effect<Action> {
        switch action {
        
        case .path(.element(_, action: .workoutHistory(.delegate(let delegateAction)))):
            switch delegateAction {
            case .selected(let item):
                state.path.append(.workoutHistoryDetails(.init(item: .init(item: item))))
            }
            return .none
            
        case .path(.element(_, action: .testWorkouts(.delegate(let delegateAction)))):
            switch delegateAction {
            case .openWorkout(let exercise):
                state.path.append(.workout(WorkoutHolderFeature.State(exercise: exercise)))
            case .openWorkoutDetails(let workoutDetails):
                state.path.append(.workoutDetails(.init(details: workoutDetails)))
            }
            return .none
            
        case .path(.element(_, action: .multipleExerciseWorkout(.delegate(let delegateAction)))):
            switch delegateAction {
            case .openWorkout(let exercise):
                state.path.append(.workout(WorkoutHolderFeature.State(exercise: exercise)))
                
            case .openWorkoutDetails(let workoutDetails):
                state.path.append(.workoutDetails(.init(details: workoutDetails)))
            }
            return .none
            
        case .path(.element(_, action: .workoutDetails(.delegate(let delegateAction)))):
            switch delegateAction {
            case .onStartWorkout(let workout):
                //state.path.append(.workout(.init(currentExercise: .init(exercise: workout.exercise))))
                state.path.append(.workoutHandler(.init(exercise: workout.exercise)))
            }
            return .none

        case .path(.element(_, action: .workoutCollection(.delegate(let delegateAction)))):
            switch delegateAction {
            case .startWorkout(let workout):
                state.path.append(.workoutDetails(.init(details: workout)))
            }
            return .none
            
        case .root(.home(.delegate(let actionDelegate))):
            switch actionDelegate {
            case .openFreeWorkout:
                let exercise: Exercise = .init(id: UUID().uuidString, name: "Free Workout", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: false, subExercises: [])
                
                state.path.append(.workout(.init(exercise: exercise)))
                            
            case .openWorkoutHistory:
                state.path.append(.workoutHistory(.init()))
                
            case .openMultipleExerciseWorkout:
                state.path.append(.multipleExerciseWorkout(.init()))
                
            case .openWorkoutCollection:
                state.path.append(.workoutCollection(.init()))
                
            case .openWorkoutBuilder:
                state.path.append(.workoutBuilder(.init(exercise: .init(id: UUID().uuidString, name: DummyData().workoutNames.randomElement() ?? "Built workout", type: .exercise, durationInMillis: nil, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []))))
                
            case .openTestWorkouts:
                state.path.append(.testWorkouts(.init()))
            case .openTempView:
                state.path.append(.workout(.init(exercise: Exercise(id: "w1d1", name: "W1D1: Sweaty Emom", type: .exercise, durationInMillis: 16 * 60 * 1000, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: true, canSkipExercise: false, subExercises: [
                                        Exercise(id: "pushup", name: "Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 1, exerciseRepetition: 0, data: .int(10), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[0]),
                                        Exercise(id: "squats", name: "Squats", type: .exercise, durationInMillis: 60 * 1000, idx: 2, exerciseRepetition: 0, data: .int(15), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[1]),
                                        Exercise(id: "bicycle", name: "Bicycle Crunches", type: .exercise, durationInMillis: 60 * 1000, idx: 3, exerciseRepetition: 0, data: .int(15), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[2]),
                                        Exercise(id: "inAndOut", name: "In And Out Jumps", type: .exercise, durationInMillis: 60 * 1000, idx: 4, exerciseRepetition: 0, data: .int(10), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[3])
                                    ]))))
                return .none
//                state.path.append(.workoutHandler(Exercise(id: "w1d1", name: "W1D1: Sweaty Emom", type: .exercise, durationInMillis: 16 * 60 * 1000, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: true, canSkipExercise: false, subExercises: [
//                    Exercise(id: "pushup", name: "Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 1, exerciseRepetition: 0, data: .int(10), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[0]),
//                    Exercise(id: "squats", name: "Squats", type: .exercise, durationInMillis: 60 * 1000, idx: 2, exerciseRepetition: 0, data: .int(15), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[1]),
//                    Exercise(id: "bicycle", name: "Bicycle Crunches", type: .exercise, durationInMillis: 60 * 1000, idx: 3, exerciseRepetition: 0, data: .int(15), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[2]),
//                    Exercise(id: "inAndOut", name: "In And Out Jumps", type: .exercise, durationInMillis: 60 * 1000, idx: 4, exerciseRepetition: 0, data: .int(10), loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[3])
//                ])))
            }
            
            return .none
            
        case .root(.home(.view)):
            return .none
            
        case .path(.element(_, action: .workout)),
                .path(.element(_, action: .workoutHistory)),
                .path(.element(_, action: .multipleExerciseWorkout)),
                .path(.element(_, action: .workoutHistoryDetails)),
                .path(.element(_, action: .workoutCollection)),
                .path(.popFrom),
                .path(.push):
            return .none
            
        case .path(.element(_, action: .workoutBuilder(.delegate(let delegateAction)))):
            switch delegateAction {
            case .dismiss:
                return _popOrClose(state: &state)
            }
            
        case .path(.element(_, action: .workoutBuilder)):
            return .none
        case .path(.element(_, action: .workoutDetails(.view))):
            return .none
            
        case .path(.element(_, action: .testWorkouts)):
            return .none
        case .path(.element(id: let id, action: .workoutHandler(_))):
            return .none
        }
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
    }
    
    private func _safeClose() -> Effect<Action> {
        return .send(.delegate(.closeFlow))
    }
    
    private func _popOrClose(state: inout State) -> Effect<Action> {
        if state.path.isEmpty {
            return _safeClose()
        } else {
            _ = state.path.popLast()
            return .none
        }
    }
}
