//
//  WorkoutDetailsFeature.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 26. 03. 24.
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
struct WorkoutDetailsFeature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        @Shared(.workouts) var builtExercises: [RepsExercise] = []
        let details: WorkoutDetailsItem
        var duration: String {
            return toDurationLongString(duration: details.exercise.totalDuration())
        }
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction: Equatable {
            case onDelete
        }
        
        enum DelegateAction: Equatable {
            case onStartWorkout(WorkoutDetailsItem)
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
        }
    }
    
    private func _reduce(into state: inout State, action: Action.ViewAction) -> Effect<Action> {
        switch action {
            
        case .onDelete:
            state.builtExercises.removeAll(where: { $0 == state.details.exercise })
            return .none
        }
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
    }
}

struct WorkoutDetailsItem: Equatable, Identifiable {
    let id: String
    let title: String
    let description: String
    let canDelete: Bool
    let exercise: RepsExercise
    
    init(id: String, title: String, description: String, canDelete: Bool = false, exercise: RepsExercise) {
        self.id = id
        self.title = title
        self.description = description
        self.canDelete = canDelete
        self.exercise = exercise
    }
}
