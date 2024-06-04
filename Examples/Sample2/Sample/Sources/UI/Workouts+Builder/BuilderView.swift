//
//  BuilderView.swift
//  InWorkoutTools
//
//  Created by Filip Božić on 12. 04. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation
import SwiftUI
import ComposableArchitecture
import CommonModels

public struct WorkoutBuilderRootView: View {
    
    @Bindable var store: StoreOf<WorkoutBuilderRootFeature>
    private var builder: StoreOf<WorkoutBuilderFeature>
    @Environment(\.dismiss) var dismiss
    
    public init(store: StoreOf<WorkoutBuilderRootFeature>) {
        self.store = store
        self.builder = store.scope(
            state: \.builder,
            action: \.builder
        )
    }
    
    public var body: some View {
        
        VStack {
            VStack {
                TopView() {
                    dismiss()
                }
                
                HStack {
                    Text("Create your workout")
                        .font(.f25bold)
                        .padding(.leading, 15)
                    
                    Spacer()
                }
                .padding(.top, 15)
            }
            .padding(.top, 15)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Workout name")
                    .font(.f15regular)
                    .foregroundStyle(Color(UIColor.lightGray))
                
                TextField("Enter workout name", text: $store.rootExercise.name.sending(\.view.onWorkoutRename))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.f17regular)
            }
            .padding(20)
            
            Spacer()
            
            NavigationLink {
                WorkoutBuilderView(store: builder)
            } label: {
                Text("Add some exercises")
            }
            .buttonStyle(.primaryButton)
        }
        .toolbar(.hidden)
    }
}

public struct WorkoutBuilderView: View {
    @Bindable var store: StoreOf<WorkoutBuilderFeature>
    @Environment(\.dismiss) var dismiss

    public var body: some View {
        VStack {
            BuilderTopView {
                dismiss()
            }
            
            List {
                ForEach(store.scope(state: \.exercises, action: \.business.subExerciseList)) { exerciseStore in
                    @Bindable var exerciseStore = exerciseStore
                    NavigationLink {
                        WorkoutBuilderView(store: exerciseStore)
                    } label: {
                        ExerciseBuilderView(exerciseStore: exerciseStore)
                    }
                }
                .onDelete { store.send(.view(.onDelete($0))) }
            }
            .listStyle(.plain)
            .navigationTitle("Workout Builder")
            .toolbar(.hidden)
            .background(Color(UIColor.systemBackground))
        }
    }
    
    private func getRandomExerciseName() -> String {
        DummyData().exerciseNames.randomElement() ?? ""
    }
    
    private func getRandomMedia() -> Media? {
        if Bool.random() {
            return DummyData().emilyVideos.randomElement()
        } else {
            return nil
        }
    }
    
    @ViewBuilder
    private func BuilderTopView(onBack: @escaping () -> Void) -> some View {
        TopView() {
            dismiss()
        }
        
        HStack {
            Text("Add an exercise")
                .font(.f25bold)
                .padding(.leading, 15)
            
            Spacer()
            
            Button {
                store.send(.view(.onAddExercise(
                    RepsExercise(id: UUID().uuidString, name: getRandomExerciseName(), type: .exercise, durationInMillis: 0, idx: 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: true, subExercises: [], media: getRandomMedia())
                )))
            } label: {
                Image(systemName: "plus")
            }.buttonStyle(.plusButton)
            
            Button("Save") {
                store.send(.view(.onSave))
            }.buttonStyle(.addExerciseButton)
        }
        .padding(.top, 15)
    }
}

struct ExerciseBuilderView: View {
    @Bindable var exerciseStore: StoreOf<WorkoutBuilderFeature>
    let types: [ExerciseType] = ExerciseType.allCases
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Name")
                    .font(.f13regular)
                    .foregroundStyle(Color(UIColor.lightGray))
                
                TextField("Enter exercise name", text: $exerciseStore.exercise.name.sending(\.view.onNameChange))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.f15regular)
            }
            .padding(.horizontal, 10)

            
            Picker("Type:", selection: $exerciseStore.exercise.type.sending(\.view.onExerciseTypeChange)) {
                ForEach(types, id: \.self) { type in
                    Text("\(type)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
            .font(.f15regular)
            
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Duration")
                        .foregroundStyle(Color(UIColor.lightGray))
                        .font(.f13regular)
                                        
                    TextField("", text: $exerciseStore.duration.sending(\.view.onExerciseTimeIntervalChange))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                        .multilineTextAlignment(.center)
                        .font(.f15regular)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Cycles")
                        .font(.f13regular)
                        .foregroundStyle(Color(UIColor.lightGray))
                                        
                    Picker("", selection: $exerciseStore.exercise.exerciseRepetition.sending(\.view.onExerciseCyclesChange)) {
                        ForEach(0...100, id: \.self) { reps in
                            Text("\(reps)")
                        }
                    }
                    .pickerStyle(.menu)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                    .shadow(radius: 0.4)
                    .font(.f15regular)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Reps")
                        .font(.f13regular)
                        .foregroundStyle(Color(UIColor.lightGray))
                                        
                    Picker("", selection: $exerciseStore.exercise.reps.sending(\.view.onExerciseRepsChange)) {
                        Text("None").tag(nil as Int?)
                        ForEach(0...100, id: \.self) { reps in
                            Text("\(reps)").tag(reps as Int?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                    .shadow(radius: 0.4)
                    .font(.f15regular)
                }
            }
            .padding(.horizontal, 10)
            
            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Text("Loop exercises")
                        .font(.f13regular)
                        .foregroundStyle(Color(UIColor.lightGray))
                    
                    Toggle("", isOn: $exerciseStore.exercise.loopSubExercises.sending(\.view.onExerciseLoopChange))
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        .frame(maxWidth: 60, alignment: .center)
                }
                .padding(.leading, 30)
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Skip exercises")
                        .font(.f13regular)
                        .foregroundStyle(Color(UIColor.lightGray))
                    
                    Toggle("", isOn: $exerciseStore.exercise.canSkipExercise.sending(\.view.onExerciseCanSkipChange))
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        .frame(maxWidth: 60, alignment: .center)
                }
                .padding(.trailing, 30)
            }
            
            Menu {
                Picker(selection: $exerciseStore.media.sending(\.view.onExerciseMediaChange), label: EmptyView(), content: {
                    Text("None").tag(nil as String?)
                    ForEach(DummyData().emilyVideos, id: \.self) { media in
                        if let name = media.url?.lastPathComponent {
                            Text("\(String(describing: name))").tag(name as String?)
                        }
                    }
                })
            } label: {
                Text(exerciseStore.media ?? "None")
                    .lineLimit(1)
                    .font(.f15regular)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .frame(height: 35)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 4).fill(.white))
            .shadow(radius: 0.4)

        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
