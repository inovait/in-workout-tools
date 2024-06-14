// 
//  TempViewForWorkoutHandler.swift
//  InWorkoutTools

//  Created by Filip Božić on 13. 5. 24
//  Copyright © 2024, Inova IT – All Rights Reserved.
// 
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
// 
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation
import WorkoutFramework
import CommonModels
import SwiftUI
import ComposableArchitecture

public struct TempView: View {
    let store: StoreOf<WorkoutHolderFeature>
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        TempView2(workout: WorkoutHandler(), exercise: store.exercise) {
            dismiss()
        }
    }
}

public struct TempView2: View {
    
    @StateObject var workout: WorkoutHandler
    let exercise: Exercise
    let dismiss: () -> Void
    
    private let media = DummyData().emilyVideos
    
    public var body: some View {
        VStack {
            if workout.exerciseHasMedia {
                VideoView(currentMedia: workout.media, player: workout.player)
            }
            Text(workout.workoutName)
            Text(workout.exerciseName)
            Text(workout.runningExerciseTimeString)
            Text(workout.workoutTotalTime?.description ?? "")
            Text(workout.reps ?? "0")
            if workout.status != .ended {
                Button {
                    workout.startWorkout()
                } label: {
                    Text("Start")
                }
                .padding()
                
                Button {
                    workout.pauseWorkout()
                } label: {
                    Text("Pause")
                }
                .padding()
                
                Button {
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
                    dismiss()
                } label: {
                    Text("End")
                }
                .padding()
            } else {
                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
                .padding()
            }
        }
        .padding()
        .task {
            workout.initialize(exercise: self.exercise)
        }
    }
}
