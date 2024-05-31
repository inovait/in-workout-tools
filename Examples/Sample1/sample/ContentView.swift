//
//  ContentView.swift
//  sample
//
//  Created by Filip Božić on 18. 4. 24.
//

import SwiftUI
import WorkoutFramework
import CommonModels
import ComposableArchitecture

struct ContentView: View {
    @StateObject var workout = WorkoutHandler()
    let store = Store(initialState: ExampleReducer.State(), reducer: { ExampleReducer() })

    public var body: some View {
            VStack {
                WithViewStore(store, observe: \.some) { some in
                    Text(some.description)
                }
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)

                Text(workout.workoutName)
                Text(workout.exerciseName)
                Text(workout.workoutTimeString)
                Button {
                    workout.startWorkout()
                } label: {
                    Text("Start")
                }
                .padding()
                
                Button {
                    store.send(.business(.increment))
                    workout.pauseWorkout()
                } label: {
                    Text("Pause")
                }
                .padding()
                
                Button {
                    store.send(.business(.decrement))
                    workout.resumeWorkout()
                } label: {
                    Text("Resume")
                }
                .padding()
                
                Button {
                    workout.nextRound()
                } label: {
                    Text("Next")
                }
                .padding()
                
                Button {
                    workout.previousRound()
                } label: {
                    Text("Prev")
                }
                .padding()
                
                Button {
                    workout.endWorkout()
                } label: {
                    Text("End")
                }
                .padding()
            }
            .padding()
            .task {
                workout.initialize(exercise: Exercise(id: "w1d1", name: "W1D1: Sweaty Emom", type: .exercise, durationInMillis: 16 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
                    Exercise(id: "pushup", name: "Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
                    Exercise(id: "squats", name: "Squats", type: .exercise, durationInMillis: 60 * 1000, idx: 2, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: []),
                    Exercise(id: "bicycle", name: "Bicycle Crunches", type: .exercise, durationInMillis: 60 * 1000, idx: 3, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: []),
                    Exercise(id: "inAndOut", name: "In And Out Jumps", type: .exercise, durationInMillis: 60 * 1000, idx: 4, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [])
                ]))
            }
    }
}


public protocol TCAFeatureAction {
    associatedtype ViewAction
    associatedtype DelegateAction
    associatedtype BusinessAction
    
    static func view(_: ViewAction) -> Self
    static func delegate(_: DelegateAction) -> Self
    static func business(_: BusinessAction) -> Self
}

struct ExampleReducer: Reducer {
    
    struct State: Equatable {
        public var some: Int
        
        init() {
            self.some = 0
        }
    }
    
    enum Action: TCAFeatureAction {
        
        enum ViewAction: Equatable {
            
        }
        
        enum DelegateAction: Equatable {
            
        }
        
        enum BusinessAction: Equatable {
            case increment
            case decrement
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
        switch action {
            
        case .increment:
            state.some += 1
        case .decrement:
            state.some -= 1
        }
        
        return .none
    }
}

