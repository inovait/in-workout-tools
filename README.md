# Documentation
- [Workout Framework](https://inovait.github.io/in-workout-tools/documentation/workoutframework/)
- [Workout handler](https://inovait.github.io/in-workout-tools/documentation/workoutframework/workouthandler)
## Getting started
- [Start here](https://inovait.github.io/in-workout-tools/documentation/workoutframework/gettingstarted)

# Examples
Please checkout the sample apps found here:
- [Sample 1](https://github.com/inovait/in-workout-tools/tree/main/Examples/Sample1)
- [Sample 2](https://github.com/inovait/in-workout-tools/tree/main/Examples/Sample2) - Uses Tuist

# Features

## General
- record open workout - timed workout
- record templated workouts
- supported exercise videos for each exercise or the whole workout
- supported high-intensity interval training (HIIT) workouts - [AMRAP](#https://athletics.fandom.com/wiki/AMRAP), [EMOM](#https://en.wiktionary.org/wiki/EMOM), [TABATA](#https://en.wiktionary.org/wiki/Tabata_method), RFT
- supported play, pause, next exercise, previous exercise and stop
- retrieved workouts stored on disk in a format supporting crash recovery

## Templated Workouts
The main struct holding neccessary workout data is `Exercise`.

Example:
`Exercise(id: "1", name: "Test Exercise", type: .exercise, durationInMillis: 5 * 1000, idx: 10, exerciseRepetition: 5, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [])`

This exercise named `Text Exercise` will be running for 5 seconds and will be repeated 5 times (lasting in total 25 seconds).

- `id` - id of the exercise
- `name` - name of the exercise
- `type` - can be `.exercise` or `.rest`
- `druationInMillis` - exercise duration in milliseconds, exercises with duration will end when that duration is complete, exercises without duration will never complete on their own
- `exerciseRepetition` - number of repetitions this exercise will do before it is completed
- `reps` - this is only data and does not influence exercise progress or completion in any way. Displays number of reps of the exercise (e.g. 10x Pushups)
- `loopSubExercises` - when true and when an exercise (parent exercise) contains a list of sub exercises they are looped indefinetly until the parent exercise is completed by a duration timer, skip or termination
- `canSkipExercise` - when true this exercise can be skipped calling `.view(.onNext)` action
- `subExercises` - a list of sub exercises
  
# Simple workout example
In this example the workout is started and finished after 10 seconds.

```swift
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
```
