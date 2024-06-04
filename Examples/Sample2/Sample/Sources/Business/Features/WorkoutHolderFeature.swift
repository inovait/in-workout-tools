//
//  WorkoutHolderFeature.swift
//  InWorkoutTools
//
//  Created by Filip Božić on 13. 5. 24.
//

import Foundation
import CommonTca
import ComposableArchitecture
import CommonModels

@Reducer
struct WorkoutHolderFeature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        public var exercise: RepsExercise
        
        public init(exercise: RepsExercise) {
            self.exercise = exercise
        }
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction: Equatable {
            
        }
        
        enum DelegateAction: Equatable {
            
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
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
    }
}

