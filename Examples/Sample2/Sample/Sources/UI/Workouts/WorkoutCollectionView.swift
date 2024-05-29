//
//  WorkoutCollectionView.swift
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

import SwiftUI
import ComposableArchitecture

struct WorkoutCollectionView: View {
    let store: StoreOf<WorkoutCollectionFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TopView {
                dismiss()
            }
            
            Text("Demo workouts")
                .font(.f25bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
            List {
                ForEachStore(store.scope(state: \.list, action: \.business.list)) { childStore in
                    let title = childStore.details.title
                    let duration = childStore.details.exercise.totalDuration()
                    let durationString = toDurationLongString(duration: duration)
                    let workouts = childStore.details.exercise.subExercises.reduce(0) { partialResult, exercise in
                        partialResult + (exercise.subExercises.count.zeroToNil() ?? 1)
                    }
                    
                    WorkoutItemView(title: title, time: durationString, workouts: "\(workouts) exercises") {
                        childStore.send(.delegate(.startWorkout(childStore.details)))
                    }
                    .listRow()
                    .padding(.bottom, 12)
                }
            }
            .padding(.horizontal, 24)
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
        .background(Color.screenBackground)
        .toolbar(.hidden)
    }
}

extension Int {
    func zeroToNil() -> Int? {
        guard self != 0 else { return nil }
        return self
    }
}

#Preview {
    WorkoutCollectionView(store: .init(initialState: .init(), reducer: {
        WorkoutCollectionFeature()
    }))
}
