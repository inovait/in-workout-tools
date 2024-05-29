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
import WorkoutFramework
import CommonModels

public struct ContentView: View {
    @Environment(\.pathStore) var store
    public var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.view.path)) {
            SwitchStore(store.scope(state: \.root, action: \.view.root)) { state in
                switch state {
                case .home:
                    CaseLet(/ProjectNavigationFeature.Root.State.home, action: ProjectNavigationFeature.Root.Action.home) { store in
                        HomeView(store: store)
                    }
                }
            }
        } destination: { store in
            switch store.case {
            case .workout(let store):
                TempView(store: store)
                    .toolbar(.hidden)
                    .ignoresSafeArea(edges: .top)
                
            case .workoutHistory(let store):
                WorkoutHistoryView(store: store)
                
            case .workoutHistoryDetails(let store):
                WorkoutHistoryDetailsView(store: store)

            case .multipleExerciseWorkout(let store):
                MutlipleWorkoutView(store: store)
                
            case .workoutCollection(let store):
                WorkoutCollectionView(store: store)
                
            case .workoutDetails(let store):
                WorkoutDetailsView(store: store)
                
            case .workoutBuilder(let store):
                WorkoutBuilderRootView(store: store)
                
            case .testWorkouts(let store):
                TestWorkoutView(store: store)
                
            case .workoutHandler(let store):
                TempView(store: store)
            }
        }
        .preferredColorScheme(.light)
    }
}

public struct HomeView: View {
    let store: StoreOf<HomeFeature>
    
    public var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("My workouts")
                    .font(.f25bold)
                    .foregroundStyle(.primary)
                    .padding(.vertical, 24)
                
                Spacer()
                
                Button {
                    store.send(.delegate(.openWorkoutBuilder))
                } label: {
                    Image(systemName: "plus")
                }.buttonStyle(.plusButton)
            }
            
            HomeActionCard(title: "Demo workout collection", subtitle: "Workouts", buttonText: "Explore", onClicked: {
                store.send(.delegate(.openWorkoutCollection))
            })
            
            HomeActionCard(title: "Workouts", subtitle: "Workouts from builder", buttonText: "Explore", onClicked: {
                store.send(.delegate(.openMultipleExerciseWorkout))
            })
            
            HomeActionCard(title: "Test workouts", subtitle: "Test workouts for SDK dev", buttonText: "Explore", onClicked: {
                store.send(.delegate(.openTestWorkouts))
            })
            
            FreeWorkoutItemView {
                store.send(.delegate(.openFreeWorkout))
            }
            
            HomeActionCard(title: "Testing workouts", subtitle: "Workout History", buttonText: "Explore", onClicked: {
                store.send(.delegate(.openWorkoutHistory))
            })
            
            HomeActionCard(title: "Testing workouts", subtitle: "Workout Handler", buttonText: "Explore", onClicked: {
                store.send(.delegate(.openTempView))
            })
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.top, 40)
        .background(Color.screenBackground)
        .toolbar(.hidden)
    }
}

@ViewBuilder
func FreeWorkoutItemView(onClicked: @escaping () -> Void) -> some View {
    HomeActionCard(title: "Do your own thing", subtitle: "Free workout", buttonText: "Start now", onClicked: onClicked)
}

@ViewBuilder
func HomeActionCard(title: String, subtitle: String, buttonText: String, onClicked: @escaping () -> Void) -> some View {
    HStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.f13regular).foregroundStyle(.secondary)
            Text(subtitle).font(.f17bold).foregroundStyle(.primary).padding(.top, 4)
        }
        Spacer()
        Button(buttonText, action: onClicked)
            .buttonStyle(.secondaryButton)
    }
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    .padding(20)
    .background(RoundedRectangle(cornerRadius: 6).fill(Color.surface))
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
