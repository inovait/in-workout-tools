//
//  ContentView.swift
//  sample
//
//  Created by Filip Božić on 18. 4. 24.
//

import SwiftUI
import WorkoutFramework
import CommonModels

public struct ContentView: View {
    @StateObject var workout = WorkoutHandler()
    let exercise: Exercise = Exercise(id: "1", name: "Test Exercise", type: .exercise, durationInMillis: 5 * 1000, idx: 10, exerciseRepetition: 5, data: .int(0), loopSubExercises: false, canSkipExercise: true, subExercises: [])

    public var body: some View {
        VStack {
            if workout.exerciseHasMedia {
                VideoView(currentMedia: workout.media, player: workout.player)
            }
            
            Text(workout.workoutName)
            Text(workout.runningExercise?.name ?? "")
            Text(workout.exerciseName)
            Text(workout.runningExerciseTimeString)
            Text(workout.workoutTotalTime?.description ?? "")
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
                } label: {
                    Text("End")
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

