import SwiftUI
import SomeFramework
import ComposableArchitecture
import FeatureWorkout
import FeatureExercise
import CommonModels

public struct ContentView: View {
    let store = Store(initialState: WorkoutFeature.State(roundIdx: 0, currentExercise: ExerciseFeature.State(exercise: Exercise(id: "1", name: "name", type: .exercise, durationInMillis: 10_000, idx: 1, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: []), currentTime: 0)), reducer: {WorkoutFeature() })
    public init() {}

    public var body: some View {
        VStack() {
            Text(store.status == .started ? "running" : "done")
                .padding(.top, 40)
                .padding(.bottom, 20)
                .font(.system(size: 24, weight: .bold))
            
        }.task {
            store.send(.view(.onPrepare("Start")))
            store.send(.view(.onStart))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
