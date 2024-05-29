//
//  WorkoutCollectionFeature.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 19. 03. 24.
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
struct WorkoutCollectionFeature: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var list: IdentifiedArrayOf<CollectionItemFeature.State>
        
        init() {
            self.list = .init(uniqueElements: [
                .init(details: w1d1SweatyEmom),
                .init(details: w1d2SweatyAmrap),
                .init(details: w2d1Amrap),
                .init(details: w2d2ForTime),
                .init(details: w3d1Amrap),
                .init(details: w3d2Emom),
                .init(details: w3d3Emom),
                .init(details: w4d1Tabata),
            ])
        }
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction {
            
        }
        
        enum DelegateAction {
            case startWorkout(WorkoutDetailsItem)
        }
        
        @CasePathable
        enum BusinessAction {
            case list(IdentifiedActionOf<CollectionItemFeature>)
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
        .forEach(\.list, action: \.business.list) {
            CollectionItemFeature()
        }
    }
    
    private func _reduce(into state: inout State, action: Action.ViewAction) -> Effect<Action> {
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
        switch action {
        case .list(.element(_, action: .delegate(.startWorkout(let workout)))):
            return .send(.delegate(.startWorkout(workout)))
        case .list:
            return .none
        }
    }
}

import ComposableArchitecture

@Reducer
struct CollectionItemFeature: Reducer {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let details: WorkoutDetailsItem
        var id: String {
            details.id
        }
        
        init(details: WorkoutDetailsItem) {
            self.details = details
        }
    }
    
    enum Action: TCAFeatureAction, Equatable {
        
        @CasePathable
        enum ViewAction: Equatable {
            
        }
        
        enum DelegateAction: Equatable {
            case startWorkout(WorkoutDetailsItem)
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
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
    }
}


let w1d1SweatyEmom = WorkoutDetailsItem(id: "1", title: "W1D1: Sweaty Emom", description: "EMOM means \"Every Minute On the Minute.\" You do a set of exercises within a minute, using the remaining time as rest. It's a time-efficient workout for beginners.\n\nIf you find normal push ups too challenging, you can try doing kneeling push ups instead.\n\nOne repetitions for each exercises is counted, when you perform full motion and get back in your starting position.", exercise: Exercise(id: "w1d1", name: "W1D1: Sweaty Emom", type: .exercise, durationInMillis: 16 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
    Exercise(id: "pushup", name: "Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[0]),
    Exercise(id: "squats", name: "Squats", type: .exercise, durationInMillis: 60 * 1000, idx: 2, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[1]),
    Exercise(id: "bicycle", name: "Bicycle Crunches", type: .exercise, durationInMillis: 60 * 1000, idx: 3, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[2]),
    Exercise(id: "inAndOut", name: "In And Out Jumps", type: .exercise, durationInMillis: 60 * 1000, idx: 4, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[3])
]))

let w1d2SweatyAmrap = WorkoutDetailsItem(id: "2", title: "W1D2: Sweaty AMRAP", description: "AMRAP means \"As Many Rounds/Reps As Possible.\" In a set time, do exercises repeatedly to push your limits and improve fitness. Great for beginners and pros.\n\nOne repetitions for each exercises is counted, when you perform full motion and get back in your starting position.", exercise: Exercise(id: "w1d2", name: "AMRAP", type: .exercise, durationInMillis: 20 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
    Exercise(id: "inAndOut", name: "In And Out Jumps", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[3]),
    Exercise(id: "lunges", name: "20 Lunges (each leg)", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[4]),
    Exercise(id: "bicycle", name: "Bicycle Crunches", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[2]),
    Exercise(id: "squats", name: "Squats", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[1]),
    Exercise(id: "vSit", name: "V-Sit Leg Extensions", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[28]),
]))

let w2d1Amrap = WorkoutDetailsItem(id: "3", title: "W2D1: Out&In AMPRAP", description: "AMRAP means \"As Many Rounds/Reps As Possible.\" In a set time, do exercises repeatedly to push your limits and improve fitness. Great for beginners and pros.\n\nOne repetitions for each exercises is counted, when you perform full motion and get back in your starting position.", exercise:
    Exercise(id: "w2d1", name: "AMRAP", type: .exercise, durationInMillis: 20 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
        Exercise(id: "pushup", name: "Push-Ups", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[0]),
        Exercise(id: "plank", name: "Plank", type: .exercise, durationInMillis: 30 * 1000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[25]),
        Exercise(id: "diamondPushups", name: "Diamond Push-Ups", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[15]),
        Exercise(id: "plankShoulder", name: "Plank Shoulder Taps", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[26]),
        Exercise(id: "wideArmPushup", name: "Wide-Arm Push-Ups", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, reps: 5, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[27]),
]))

let w2d2ForTime = WorkoutDetailsItem(id: "4", title: "W2D2: In&Out For Time", description: "CrossFit's \"For Time\" is an intense workout format designed to challenge and improve your fitness. In \"For Time,\" the goal is to complete a specific set of exercises as quickly as possible while maintaining proper form and technique.\n\nEach repetition counts when executed with full range of motion, and the stopwatch becomes your motivator to improve your time. It's a versatile training approach suitable for all fitness levels, fostering competitiveness and efficient progress in strength, endurance, and cardiovascular fitness.", exercise:
    Exercise(id: "w2d2", name: "For Time", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "HighKnees", name: "High Knees", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, reps: 25, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[23]),
        Exercise(id: "Squats", name: "Squats", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, reps: 25, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[1]),
        Exercise(id: "Push-Ups", name: "Push-Ups", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, reps: 50, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[0]),
        Exercise(id: "Sit-Ups Knee", name: "Sit-Ups Knee", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, reps: 75, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[24]),
        Exercise(id: "Wide-Arm Push-Ups", name: "Wide-Arm Push-Ups", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, reps: 25, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[27])
]))

let w3d1Amrap = WorkoutDetailsItem(id: "5", title: "W3D1: Indoor AMRAP", description: "AMRAP means \"As Many Rounds/Reps As Possible.\" In a set time, do exercises repeatedly to push your limits and improve fitness. Great for beginners and pros.\n\nOne repetitions for each exercises is counted, when you perform full motion and get back in your starting position.", exercise:
    Exercise(id: "w3d1", name: "AMRAP", type: .exercise, durationInMillis: 20 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
        Exercise(id: "Burpees", name: "Burpees", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[9]),
        Exercise(id: "Mountain Climbers", name: "Mountain Climbers", type: .exercise, durationInMillis: 30 * 1000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[10]),
        Exercise(id: "Hindu Pushups", name: "Hindu Pushups", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[22]),
        Exercise(id: "Deadbug Hold", name: "Deadbug Hold", type: .exercise, durationInMillis: 30 * 1000, idx: 4, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[7]),
        Exercise(id: "Incline Pushups", name: "Incline Pushups", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[6]),
]))

let w3d2Emom = WorkoutDetailsItem(id: "6", title: "W3D2: Core EMOM", description: "", exercise:
    Exercise(id: "w3d2", name: "EMOM", type: .exercise, durationInMillis: 24 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
        Exercise(id: "Bicycle Crunches", name: "Bicycle Crunches", type: .exercise, durationInMillis: 60 * 1000, idx: 1, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[2]),
        Exercise(id: "Flutter Kicks", name: "Flutter Kicks", type: .exercise, durationInMillis: 60 * 1000, idx: 2, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[21]),
        Exercise(id: "Leg raises & Plank", name: "Leg raises & Plank", type: .exercise, durationInMillis: 60 * 1000, idx: 3, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[20]),
        Exercise(id: "Russian twists", name: "Russian twists", type: .exercise, durationInMillis: 60 * 1000, idx: 4, exerciseRepetition: 0, reps: 20, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[19]),
        Exercise(id: "DeadBug Hold", name: "DeadBug Hold", type: .exercise, durationInMillis: 60 * 1000, idx: 5, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[7]),
        Exercise(id: "Rest", name: "Rest", type: .rest, durationInMillis: 60 * 1000, idx: 6, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
]))

let w3d3Emom = WorkoutDetailsItem(id: "7", title: "W3BONUS: Get out to park", description: "If you're eager to head to the nearest street workout park, here's an ideal workout for you!\n\nIf you find it challenging to perform a high number of repetitions for each exercise, don't hesitate to reduce the count to a more manageable level.", exercise:
    Exercise(id: "w3d3", name: "EMOM", type: .exercise, durationInMillis: 24 * 60 * 1000, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: true, canSkipExercise: false, subExercises: [
        Exercise(id: "Pull-Ups", name: "Pull-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[8]),
        Exercise(id: "Dips", name: "Dips", type: .exercise, durationInMillis: 60 * 1000, idx: 2, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[13]),
        Exercise(id: "Wide Push-Ups", name: "Wide Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 3, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[27]),
        Exercise(id: "Rest1", name: "Rest", type: .rest, durationInMillis: 60 * 1000, idx: 4, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        
        Exercise(id: "Chin-Ups", name: "Chin-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 5, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[14]),
        Exercise(id: "Dips2", name: "Dips", type: .exercise, durationInMillis: 60 * 1000, idx: 6, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[13]),
        Exercise(id: "Diamond Push-Ups", name: "Diamond Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 7, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[15]),
        Exercise(id: "Rest2", name: "Rest", type: .rest, durationInMillis: 60 * 1000, idx: 8, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        
        Exercise(id: "Chin-Ups2", name: "Chin-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 9, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[14]),
        Exercise(id: "Dips3", name: "Dips", type: .exercise, durationInMillis: 60 * 1000, idx: 10, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[13]),
        Exercise(id: "Bench Dips", name: "Bench Dips", type: .exercise, durationInMillis: 60 * 1000, idx: 11, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[17]),
        Exercise(id: "Rest3", name: "Rest", type: .rest, durationInMillis: 60 * 1000, idx: 12, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        
        Exercise(id: "Neutral Pull-Ups", name: "Neutral Pull-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 13, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[18]),
        Exercise(id: "Dips4", name: "Dips", type: .exercise, durationInMillis: 60 * 1000, idx: 14, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[13]),
        Exercise(id: "Push-Ups", name: "Push-Ups", type: .exercise, durationInMillis: 60 * 1000, idx: 15, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[0]),
        
]))
    
let w4d1Tabata = WorkoutDetailsItem(id: "8", title: "W4D1: Sweaty Tabata babyyy", description: "", exercise: Exercise(id: "Tabata", name: "Tabata", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "t1", name: "Tabata Mountain Climbers", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "Mountain Climbers", name: "Mountain Climbers", type: .exercise, durationInMillis: 5 * 1000, idx: 2, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[10]),
        Exercise(id: "Rest1", name: "Rest", type: .rest, durationInMillis: 3 * 1000, idx: 3, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: true, subExercises: []),
    ]),
    Exercise(id: "Rest and prepare for Step UpsRest and prepare for Step Ups", name: "Rest and prepare for Step Ups", type: .rest, durationInMillis: 10 * 1000, idx: 4, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    
    Exercise(id: "t2", name: "Tabata Step Ups", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Step Ups", name: "Step Ups", type: .exercise, durationInMillis: 5 * 1000, idx: 6, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[11]),
        Exercise(id: "Rest2", name: "Rest", type: .rest, durationInMillis: 3 * 1000, idx: 7, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ]),
    Exercise(id: "Rest and prepare for Bicycle Crunches", name: "Rest and prepare for Bicycle Crunches", type: .rest, durationInMillis: 10 * 1000, idx: 8, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    
    Exercise(id: "t3", name: "Tabata Bicycle Crunches", type: .exercise, durationInMillis: 0, idx: 9, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Bicycle Crunches", name: "Bicycle Crunches", type: .exercise, durationInMillis: 5 * 1000, idx: 10, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[2]),
        Exercise(id: "Rest3", name: "Rest", type: .rest, durationInMillis: 3 * 1000, idx: 11, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ]),
    Exercise(id: "Rest and prepare for Reverse Lunges", name: "Rest and prepare for Reverse Lunges", type: .rest, durationInMillis: 10 * 1000, idx: 12, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    
    Exercise(id: "t4", name: "Tabata Reverse Lunges", type: .exercise, durationInMillis: 0, idx: 13, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Reverse Lunges", name: "Reverse Lunges", type: .exercise, durationInMillis: 5 * 1000, idx: 14, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: [], media: media[12]),
        Exercise(id: "Rest4", name: "Rest", type: .rest, durationInMillis: 3 * 1000, idx: 15, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ])
]))

private let media = DummyData().emilyVideos
