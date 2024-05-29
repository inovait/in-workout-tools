//
//  WorkoutHistoryDetailsView.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 29. 02. 24.
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

struct WorkoutHistoryDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let store: StoreOf<WorkoutHistoryDetailsFeature>
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                TopView(onBack: { dismiss() })
                Text(store.item.item.data.name)
                    .font(.f21bold)
                    .padding(24)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        if store.item.item.data.duration != 0 {
                            DetailsTimeView(toDurationLongString(duration: Double(store.item.item.data.duration) * 1000.0))
                                .padding(.horizontal, 24)
                        }
                                                
                        Text("Exercises")
                            .font(.f21bold)
                            .padding(.horizontal, 24)
                            .padding(.top, 8)
                        
                        BreakdownView(store.item.item.data.breakdown.toExercises())
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background(Color.surface)
                            .cornerRadius(6)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                    }
                    .padding(.bottom, 80)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color.screenBackground)
        .toolbar(.hidden)
    }
}

#Preview {
    WorkoutHistoryDetailsView(store: Store(initialState: {
        WorkoutHistoryDetailsFeature.State(item: .init(item: .init(idx: 0, data: RecordedWorkout(timestamp: 65455, duration: 654564, name: "Test", breakdown: [
            RecordedBreakdownItem(roundIdx: 0, timestamp: 123, type: .roundEnded, duration: 654, exerciseName: "Ex1"),
            RecordedBreakdownItem(roundIdx: 1, timestamp: 125, type: .roundEnded, duration: 700, exerciseName: "Ex1"),
                                                                                                                                                              ]))))
    }(), reducer: {
        WorkoutHistoryDetailsFeature()
    }))
}
