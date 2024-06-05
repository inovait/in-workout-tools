//
//  TestWorkoutView.swift
//  InWorkoutTools
//
//  Created by Filip Božić on 17. 4. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import SwiftUI
import ComposableArchitecture
import CommonModels

struct TestWorkoutView: View {
    let store: StoreOf<MultipleWorkoutFeature>
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            TopView {
                dismiss()
            }
            Text("Test workouts")
                .font(.f25bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
            
            List {
                
                WorkoutItemView(title: "Weirdly nested exercise", time: "NA", workouts: "dont know...") {
                    store.send(.delegate(.openWorkoutDetails(weirdlyNested)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Exercise repeats", time: "NA", workouts: "5 repeats 1 workout") {
                    store.send(.delegate(.openWorkout(repeats)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: subExercises.title, time: "NA", workouts: "5 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercises)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Sub Exercises2", time: "NA", workouts: "6 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercises2)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Sub Exercises2Duration", time: "NA", workouts: "6 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercises2Duration)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Sub Exercises single", time: "NA", workouts: "3 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercisesSingle)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Sub Exercises loop", time: "NA", workouts: "3 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercisesLoop)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Sub Exercises loop duration", time: "NA", workouts: "3 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercisesLoopDuration)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Sub Exercises loop for duration", time: "NA", workouts: "3 workouts") {
                    store.send(.delegate(.openWorkoutDetails(subExercisesLoopForDuration)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "4 rounds with duration - 10sec each", time: "NA", workouts: "4 workouts") {
                    store.send(.delegate(.openWorkoutDetails(rounds4withDuration)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "3 rounds without duration", time: "NA", workouts: "3 workouts") {
                    store.send(.delegate(.openWorkoutDetails(rounds3WithoutDuration)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "2 rounds without duration, 2 with duration", time: "NA", workouts: "4 workouts") {
                    store.send(.delegate(.openWorkoutDetails(rounds2withDuration2WithoutDuration)))
                }
                .listRow()
                .padding(.bottom, 12)

                WorkoutItemView(title: "Media test 9 rounds", time: "NA", workouts: "9 workouts") {
                    store.send(.delegate(.openWorkoutDetails(rounds9WithoutDuration)))
                }
                .listRow()
                .padding(.bottom, 12)
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 24)
        }
        .toolbar(.hidden)
        .background(Color.screenBackground)
    }
}
#Preview {
    MutlipleWorkoutView(store: .init(initialState: MultipleWorkoutFeature.State.init(), reducer: {
        MultipleWorkoutFeature()
    }))
}

private let subExercises = WorkoutDetailsItem(id: "1", title: "Sub exercises", description: "2 exercises with sub exercises with duration", exercise:
    Exercise(id: "main", name: "Sub exercises", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
            Exercise(id: "11", name: "P1/C1", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
            Exercise(id: "12", name: "P1/C2", type: .exercise, durationInMillis: 3_000, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
            Exercise(id: "13", name: "P1/C3", type: .exercise, durationInMillis: 3_500, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
        ]),
        Exercise(id: "2", name: "P2", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
            Exercise(id: "21", name: "P2/C1", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
            Exercise(id: "22", name: "P2/C2", type: .exercise, durationInMillis: 3_000, idx: 7, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        ]),
    ])
)

private let weirdlyNested = WorkoutDetailsItem(id: "1", title: "Weirdly nested", description: "Testing nesting as much as possible", exercise:
    Exercise(id: "main", name: "Sub exercises", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "1", name: "1", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
            Exercise(id: "11", name: "11", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
                Exercise(id: "111", name: "111-", type: .exercise, durationInMillis: 3_000, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
                Exercise(id: "112", name: "112-", type: .exercise, durationInMillis: 3_500, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
            ]),
            Exercise(id: "12", name: "12+", type: .exercise, durationInMillis: 3_000, idx: 5, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
            Exercise(id: "13", name: "13", type: .exercise, durationInMillis: 0, idx: 6, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
                Exercise(id: "131", name: "131+", type: .exercise, durationInMillis: 3_000, idx: 7, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
                Exercise(id: "132", name: "132", type: .exercise, durationInMillis: 7_500, idx: 8, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
                    Exercise(id: "1321", name: "1321+", type: .exercise, durationInMillis: 3_000, idx: 9, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
                    Exercise(id: "1322", name: "1322+", type: .exercise, durationInMillis: 0, idx: 10, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
                ])
            ])
        ]),
        Exercise(id: "2", name: "2", type: .exercise, durationInMillis: 0, idx: 11, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
            Exercise(id: "21", name: "21", type: .exercise, durationInMillis: 0, idx: 12, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
                Exercise(id: "211", name: "211", type: .exercise, durationInMillis: 0, idx: 13, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
                    Exercise(id: "2111", name: "2111", type: .exercise, durationInMillis: 0, idx: 14, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
                        Exercise(id: "21111", name: "21111+", type: .exercise, durationInMillis: 3_000, idx: 15, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
                        Exercise(id: "21112", name: "21112+", type: .exercise, durationInMillis: 3_000, idx: 16, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
                    ])
                ])
            ]),
            Exercise(id: "22", name: "22+", type: .exercise, durationInMillis: 3_000, idx: 17, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        ]),
    ])
)

private let subExercises2 = WorkoutDetailsItem(id: "1", title: "Sub exercises 2", description: "2 exercises with sub exercises no duration", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "1.1", name: "P1/C1", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[0]),
        Exercise(id: "1.2", name: "P1/C2", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[4]),
        Exercise(id: "1.3", name: "P1/C3", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[7])
    ], media: media[8]),
    Exercise(id: "2", name: "P2", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "2.1", name: "P2/C1", type: .exercise, durationInMillis: 0, idx: 6, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[6]),
        Exercise(id: "2.2", name: "P2/C2", type: .exercise, durationInMillis: 0, idx: 7, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "2.3", name: "P2/C3", type: .exercise, durationInMillis: 0, idx: 8, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
    ], media: media[1]),
]))

private let subExercises2Duration = WorkoutDetailsItem(id: "1", title: "Sub exercises 2", description: "2 exercises with sub exercises duration", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "1.1", name: "P1/C1", type: .exercise, durationInMillis: 6_000, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[0]),
        Exercise(id: "1.2", name: "P1/C2", type: .exercise, durationInMillis: 6_000, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.3", name: "P1/C3", type: .exercise, durationInMillis: 6_000, idx: 5, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[5])
    ], media: media[8]),
    Exercise(id: "2", name: "P2", type: .exercise, durationInMillis: 0, idx: 6, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "2.1", name: "P2/C1", type: .exercise, durationInMillis: 6_000, idx: 7, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "2.2", name: "P2/C2", type: .exercise, durationInMillis: 6_000, idx: 8, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[6]),
        Exercise(id: "2.3", name: "P2/C3", type: .exercise, durationInMillis: 6_000, idx: 9, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
    ], media: media[1])
]))

private let repeats =
Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 5 * 1000, idx: 10, exerciseRepetition: 5, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])

private let subExercisesLoop = WorkoutDetailsItem(id: "1", title: "Sub Exercises loop", description: "Sub Exercises loop", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: true, canSkipExercise: true, subExercises: [
        Exercise(id: "1.1", name: "P1/E1", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[1]),
        Exercise(id: "1.2", name: "P1/E2", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.3", name: "P1/E3", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[5])
    ], media: media[0])
]))

private let subExercisesLoopDuration = WorkoutDetailsItem(id: "1", title: "Sub Exercises loop duration", description: "Sub Exercises loop duration", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 3_000, idx: 10, exerciseRepetition: 0, data: .int(0), loopSubExercises: true, canSkipExercise: true, subExercises: [
        Exercise(id: "1.1", name: "P1/E1", type: .exercise, durationInMillis: 0, idx: 20, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.2", name: "P1/E2", type: .exercise, durationInMillis: 0, idx: 30, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.3", name: "P1/E2", type: .exercise, durationInMillis: 0, idx: 40, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
    ])
]))

private let subExercisesSingle = WorkoutDetailsItem(id: "1", title: "Sub Exercises single", description: "Sub Exercises single", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "Parent", type: .exercise, durationInMillis: 0, idx: 10, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "1.1", name: "1 Exercise", type: .exercise, durationInMillis: 0, idx: 20, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.2", name: "2 Exercise", type: .exercise, durationInMillis: 0, idx: 30, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.3", name: "3 Exercise", type: .exercise, durationInMillis: 0, idx: 40, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
    ])
]))

private let subExercisesLoopForDuration = WorkoutDetailsItem(id: "1", title: "Sub Exercises loop for duration", description: "Sub Exercises loop for duration", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 10, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "Parent", type: .exercise, durationInMillis: 10_000, idx: 20, exerciseRepetition: 0, data: .int(0), loopSubExercises: true, canSkipExercise: true, subExercises: [
        Exercise(id: "1.1", name: "1 Exercise", type: .exercise, durationInMillis: 0, idx: 30, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.2", name: "2 Exercise", type: .exercise, durationInMillis: 0, idx: 40, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "1.3", name: "3 Exercise", type: .exercise, durationInMillis: 0, idx: 50, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])
    ])
]))

private let rounds3WithoutDuration = WorkoutDetailsItem(id: "1", title: "3 rounds without duration", description: "3 rounds without duration", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    
    Exercise(id: "1", name: "3roundNoDuration", type: .exercise, durationInMillis: 0, idx: 10, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[1]),
    Exercise(id: "2", name: "no duration 2", type: .exercise, durationInMillis: 0, idx: 20, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[3]),
    Exercise(id: "3", name: "no duration 3", type: .exercise, durationInMillis: 0, idx: 30, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[5])
]))

private let rounds2withDuration2WithoutDuration = WorkoutDetailsItem(id: "1", title: "2 rounds without duration, 2 with duration", description: "2 rounds without duration, 2 with duration", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "2dur2without", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "2", name: "dur2", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "3", name: "dur3", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "4", name: "dur4", type: .exercise, durationInMillis: 3_000, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
]))

private let rounds4withDuration = WorkoutDetailsItem(id: "1", title: "4 rounds with duration - 10sec each", description: "4 rounds with duration - 10sec each", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "4durations", type: .exercise, durationInMillis: 3_000, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "2", name: "dur2", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "3", name: "dur3", type: .exercise, durationInMillis: 3_000, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "4", name: "dur4", type: .exercise, durationInMillis: 3_000, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
]))

private let rounds9WithoutDuration = WorkoutDetailsItem(id: "1", title: "Media test 9 rounds", description: "Media test 9 rounds", exercise: Exercise(id: "Parent", name: "Parent", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [
    Exercise(id: "1", name: "3roundNoDuration", type: .exercise, durationInMillis: 0, idx: 1, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[0]),
    Exercise(id: "2", name: "no duration 2", type: .exercise, durationInMillis: 0, idx: 2, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "3", name: "no duration 3", type: .exercise, durationInMillis: 0, idx: 3, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[3]),
    Exercise(id: "4", name: "4roundNoDuration", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[6]),
    Exercise(id: "5", name: "no duration 5", type: .exercise, durationInMillis: 0, idx: 5, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[8]),
    Exercise(id: "6", name: "no duration 6", type: .exercise, durationInMillis: 0, idx: 6, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[10]),
    Exercise(id: "7", name: "7roundNoDuration", type: .exercise, durationInMillis: 0, idx: 7, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "8", name: "no duration 8", type: .exercise, durationInMillis: 0, idx: 8, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: []),
    Exercise(id: "9", name: "no duration 9", type: .exercise, durationInMillis: 0, idx: 9, exerciseRepetition: 0, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [], media: media[14])
]))

private let media = DummyData().exampleMedia
