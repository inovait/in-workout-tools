//
//  WorkoutDetails.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 25. 03. 24.
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

struct WorkoutDetailsView: View {
    let store: StoreOf<WorkoutDetailsFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        _WorkoutDetailsView(title: store.details.title, duration: store.duration, description: store.details.description, exercises: store.details.exercise.subExercises, canDelete: store.details.canDelete, onStartWorkout: {
            store.send(.delegate(.onStartWorkout(store.details)))
        }) {
            dismiss()
        } onDelete: {
            store.send(.view(.onDelete))
            dismiss()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    _WorkoutDetailsView(title: "Muscle relaxations with Jamie Edwards", duration: "45 min", description: "4 exercises by Title’s legendary coach Jacob Fighterovic that will teach you everything you need to know to build up your reactionary time. 4 exercises by Title’s legendary coach Jacob Fighterovic that will teach you everything you need to know to build up your reactionary time. ", exercises: exercises, canDelete: false, onStartWorkout: {}, onBack: {}, onDelete: {})
}

#Preview {
    _WorkoutDetailsView(title: "Muscle relaxations with Jamie Edwards", duration: "45 min", description: "4 exercises by Title’s legendary coach Jacob Fighterovic that will teach you everything you need to know to build up your reactionary time. 4 exercises by Title’s legendary coach Jacob Fighterovic that will teach you everything you need to know to build up your reactionary time. ", exercises: exercisesTabata, canDelete: false, onStartWorkout: {}, onBack: {}, onDelete: {})
}

#Preview {
    _WorkoutDetailsView(title: "Weirdly nested", duration: "45 min", description: "Oh yes", exercises: weirdlyNested, canDelete: false, onStartWorkout: {}, onBack: {}, onDelete: {})
}

@ViewBuilder
func _WorkoutDetailsView(title: String, duration: String, description: String, exercises: [Exercise], canDelete: Bool, onStartWorkout: @escaping () -> Void, onBack: @escaping () -> Void, onDelete: @escaping () -> Void) -> some View {
    ZStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 0) {
            TopView(onBack: onBack)
            
            Text(title)
                .font(.f21bold)
                .padding(24)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if !duration.isEmpty {
                        DetailsTimeView(duration)
                            .padding(.horizontal, 24)
                    }
                    
                    Text(description)
                        .font(.f15regular)
                        .padding(24)
                    
                    Text("Workout")
                        .font(.f21bold)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    
                    BreakdownView(exercises)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color.surface)
                        .cornerRadius(6)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    
                    Spacer()
                    if canDelete {
                        Button("Delete this workout") {
                            onDelete()
                        }.buttonStyle(.deleteWorkoutButton)
                    }
                }
                .padding(.bottom, 80)
            }
        }
        
        VStack {
            Spacer()
            ZStack {
                Button("Start workout") {
                    onStartWorkout()
                }
                .buttonStyle(.primaryButton)
                .padding(.bottom, 24)
            }
            .padding(.top, 12)
            .frame(maxWidth: .infinity)
            .background(Color.screenBackground)
                
        }
    }
    .frame(maxHeight: .infinity)
    .background(Color.screenBackground)
}

@ViewBuilder
func BreakdownView(_ exercises: [Exercise]) -> some View {
    VStack {
        ForEach(exercises.indices, id: \.self) { index in
            let exercise = exercises[index]
            let value = toExerciseRepetitionsOrNil(exercise.exerciseRepetition) ?? toInWorkoutDurationOrNil(duration: exercise.totalDuration().toValueOrNull()) ?? toReps(reps: exercise.reps)
            BreakdownItemView(name: exercise.name, value: value, hasVideo: false)
            ForEach(toFlatExerciseDisplayList(exercises: exercise.subExercises, indent: 1)) { displayExercise in
                let subExercise = displayExercise.exercise
                let value = toInWorkoutDurationOrNil(duration: subExercise.totalDuration().toValueOrNull()) ?? toReps(reps: subExercise.reps)
                BreakdownItemView(name: subExercise.name, value: value, hasVideo: false)
                    .padding(.leading, CGFloat(12 * displayExercise.indent))
            }
            if (index < exercises.count - 1) {
                Rectangle()
                    .frame(height: 1)
                    .background(Color.onBackground)
                    .opacity(0.1)
                    .padding(.bottom, 4)
            }
        }
    }
}

func toFlatExerciseDisplayList(exercises: [Exercise], indent: Int) -> [ExerciseDisplay] {
    var ret: [ExerciseDisplay] = []
    for exercise in exercises {
        ret.append(ExerciseDisplay(exercise: exercise, indent: indent))
        if exercise.hasSubExercises() {
            ret.append(contentsOf: toFlatExerciseDisplayList(exercises: exercise.subExercises, indent: indent + 1))
        }
    }
    return ret
}

struct ExerciseDisplay: Equatable, Identifiable {
    var id: String {
        return exercise.id
    }
    let exercise: Exercise
    let indent: Int
}


extension TimeInterval {
    func toValueOrNull() -> TimeInterval? {
        return self != 0 ? self : nil
    }
}

@ViewBuilder
func BreakdownItemView(name: String, value: String?, hasVideo: Bool) -> some View {
    HStack() {
        if hasVideo {
            Image(.icDetailsVideo)
        }
        Text(name)
            .font(.f15regular)
            .padding(4)
        
        Spacer()
        if let value {
            Text(value)
                .padding(4)
                .font(.f13bold)
                .foregroundColor(.onBackground)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.onBackground)
                }
                
        }
    }
}

@ViewBuilder
func DetailsTimeView(_ time: String) -> some View {
    HStack {
        Image(.icDetailsTime)
        Text(time)
    }
}

private func toExerciseRepetitionsOrNil(_ value: Int) -> String? {
    guard value != 0 else { return nil }
    return "\(value)x"
}

fileprivate let exercises = [
    Exercise(id: "1", name: "P1", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "11", name: "P1/C1", type: .exercise, durationInMillis: 3_000, idx: 1, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "12", name: "P1/C2", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "13", name: "P1/C3", type: .exercise, durationInMillis: 3_500, idx: 3, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [])
    ]),
    Exercise(id: "2", name: "P2", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "21", name: "P2/C1", type: .exercise, durationInMillis: 3_000, idx: 5, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
        Exercise(id: "22", name: "P2/C2", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
    ]),
]

fileprivate let exercisesTabata = [
    Exercise(id: "t1", name: "Tabata Mountain Climbers", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Mountain Climbers", name: "Mountain Climbers", type: .exercise, durationInMillis: 20 * 1000, idx: 1, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        Exercise(id: "Rest", name: "Rest", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ]),
    Exercise(id: "Rest", name: "Rest and prepare for Step Ups", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    
    Exercise(id: "t2", name: "Tabata Step Ups", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Step Ups", name: "Step Ups", type: .exercise, durationInMillis: 20 * 1000, idx: 1, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        Exercise(id: "Rest", name: "Rest", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ]),
    Exercise(id: "Rest2", name: "Rest and prepare for Bicycle Crunches", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    
    Exercise(id: "t3", name: "Tabata Bicycle Crunches", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Bicycle Crunches", name: "Bicycle Crunches", type: .exercise, durationInMillis: 20 * 1000, idx: 1, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        Exercise(id: "Rest", name: "Rest", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ]),
    Exercise(id: "Rest2", name: "Rest and prepare for Reverse Lunges", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    
    Exercise(id: "t4", name: "Tabata Reverse Lunges", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 8, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: [
        Exercise(id: "Reverse Lunges", name: "Reverse Lunges", type: .exercise, durationInMillis: 20 * 1000, idx: 1, exerciseRepetition: 0, reps: 15, loopSubExercises: false, canSkipExercise: false, subExercises: []),
        Exercise(id: "Rest", name: "Rest", type: .rest, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 10, loopSubExercises: false, canSkipExercise: false, subExercises: []),
    ]),
]

fileprivate let weirdlyNested = [
    Exercise(id: "main", name: "Sub exercises", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
        Exercise(id: "1", name: "P1/C1", type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
            Exercise(id: "11", name: "11", type: .exercise, durationInMillis: 3_000, idx: 1, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
                Exercise(id: "111", name: "111", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
                Exercise(id: "112", name: "112", type: .exercise, durationInMillis: 3_500, idx: 3, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [])
            ]),
            Exercise(id: "12", name: "P1/C2", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
            Exercise(id: "13", name: "P1/C3", type: .exercise, durationInMillis: 3_500, idx: 3, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
                Exercise(id: "131", name: "131", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
                Exercise(id: "132", name: "132", type: .exercise, durationInMillis: 3_500, idx: 3, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
                    Exercise(id: "1321", name: "1321", type: .exercise, durationInMillis: 3_000, idx: 2, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
                    Exercise(id: "1321", name: "1321", type: .exercise, durationInMillis: 3_500, idx: 3, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [])
                ])
            ])
        ]),
        Exercise(id: "2", name: "P2", type: .exercise, durationInMillis: 0, idx: 4, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
            Exercise(id: "21", name: "P2/C1", type: .exercise, durationInMillis: 3_000, idx: 5, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
                Exercise(id: "211", name: "211", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
                    Exercise(id: "2111", name: "2111", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [
                        Exercise(id: "21111", name: "21111", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
                        Exercise(id: "21112", name: "21112", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [])
                    ])
                ])
            ]),
            Exercise(id: "22", name: "P2/C2", type: .exercise, durationInMillis: 3_000, idx: 6, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: []),
        ]),
    ])
]
