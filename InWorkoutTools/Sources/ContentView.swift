import SwiftUI
import FeatureWorkout
import ComposableArchitecture

public struct ContentView: View {
    let store = Store(initialState: WorkoutFeature.State(roundIdx: 0, currentExercise: .init(exercise: .init(id: "demo", name: "Duration 10 sec", type: .exercise, durationInMillis: 10 * 1000, idx: 1, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: []), currentTime: 0))) {
        WorkoutFeature()
    }
    
    public init() {}

    public var body: some View {
        VStack() {
            Text(store.currentExercise.exercise.name)
                .padding(.top, 40)
                .padding(.bottom, 20)
                .font(.system(size: 24, weight: .bold))
            
            Text(store.totalTime.toSeconds().description)
            
            if (store.status == .ended) {
                Text("Workout completed")
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    .font(.system(size: 24, weight: .bold))
            }
            
            Spacer()
        }.task {
            store.send(.view(.onPrepare(store.currentExercise.exercise.name)))
            store.send(.view(.onStart))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
