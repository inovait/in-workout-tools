//
//  MutlipleWorkoutView.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 1. 03. 24.
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

struct MutlipleWorkoutView: View {
    let store: StoreOf<MultipleWorkoutFeature>
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            TopView {
                dismiss()
            }
            Text("Workouts from builder")
                .font(.f25bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
            
            List {
                if !store.builtExercises.isEmpty {
                    ForEach(store.builtExercises, id: \.id) { workout in
                        WorkoutItemView(title: workout.name, time: "Made with builder", workouts: "") {
                            store.send(.delegate(.openWorkoutDetails(
                                WorkoutDetailsItem(id: UUID().uuidString, title: workout.name, description: "This Workout is made with builder", canDelete: true, exercise: workout)
                            )))
                        }
                        .listRow()
                        .padding(.bottom, 12)
                    }
                }
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

