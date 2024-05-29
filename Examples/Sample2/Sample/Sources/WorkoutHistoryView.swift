//
//  SwiftUIView.swift
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

struct WorkoutHistoryView: View {
    @Environment(\.dismiss) var dismiss
    let store: StoreOf<WorkoutHistoryFeature>
    var body: some View {
        ZStack {
            VStack {
                TopView {
                    dismiss()
                }
                
                Text("History")
                    .font(.f25bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                
                
                switch store.status {
                case .success(true):
                    List {
                        ForEachStore(store.scope(state: \.list, action: \.business.list)) { item in
                            let data = item.item.data
                            
                            WorkoutHistoryItemView(date: toLongDateTime(timestampInSeconds: data.timestamp), title: data.name, duration: toDurationLongString(duration: Double(data.duration * 1000)), workouts: data.exercisesDisplay) {
                                item.send(.view(.onSelected))
                            }
                            .listRow()
                            .padding(.bottom, 12)
                            
                            EmptyView()
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                    
                case .success(false):
                    Text("No workouts completed!").font(.f21regular).frame(maxWidth: .infinity).padding(.top, 24)
                    Spacer()
                    
                default:
                    Text("Oops something went wrong!").font(.f21regular).frame(maxWidth: .infinity).padding(.top, 24)
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                ZStack {
                    Button("Remove all") {
                        store.send(.view(.onRemoveAll))
                    }
                    .buttonStyle(.primaryButton)
                    .padding(.bottom, 24)
                }
                .padding(.top, 12)
                .frame(maxWidth: .infinity)
                .background(Color.screenBackground)
            }
        }
        .background(Color.screenBackground)
        .toolbar(.hidden)
        .task {
            store.send(.view(.onLoad))
        }
    }
}

#Preview {
    WorkoutHistoryView(store: Store(initialState: {
        WorkoutHistoryFeature.State(list: IdentifiedArray(uniqueElements: [HistoryFeature.State.init(item: WorkoutHistoryItem(idx: 0, data: RecordedWorkout(timestamp: 1712903405, duration: 8546, name: "Test Workout", breakdown: [])))]))
    }(), reducer: {
        WorkoutHistoryFeature()
    }))
}

#Preview {
    WorkoutHistoryView(store: Store(initialState: {
        WorkoutHistoryFeature.State(list: IdentifiedArray(uniqueElements: [HistoryFeature.State.init(item: WorkoutHistoryItem(idx: 0, data: RecordedWorkout(timestamp: 1712903405, duration: 8546, name: "Test Workout", breakdown: [])))]), status: .success(false))
    }(), reducer: {
        WorkoutHistoryFeature()
    }))
}


@ViewBuilder
func WorkoutHistoryItemDateView(date: String) -> some View {
    HStack {
        Rectangle().fill(.secondary).frame(width: 24, height: 1, alignment: .leading)
        Text(date).font(.f15regular).foregroundStyle(.secondary).frame(maxWidth: .infinity, alignment: .leading)
    }
}

@ViewBuilder
func WorkoutHistoryItemView(date: String, title: String, duration: String, workouts: String, onClick: @escaping () -> Void) -> some View {
    VStack {
        WorkoutHistoryItemDateView(date: date)
            .padding(.leading, 24)
        
        WorkoutItemView(title: title, time: duration, workouts: workouts, onClick: onClick)
            .padding(.horizontal, 24)
            .padding(.top, 4)
    }
}
