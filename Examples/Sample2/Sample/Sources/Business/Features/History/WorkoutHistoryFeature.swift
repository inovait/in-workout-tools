//
//  WorkoutHistoryFeature.swift
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

import Foundation
import ComposableArchitecture
import CommonTca
import WorkoutFramework

@Reducer
struct WorkoutHistoryFeature: Reducer {
    @ObservableState
    struct State: Equatable {
        var list: IdentifiedArrayOf<HistoryFeature.State>
        var status: Result<Bool, HistoryError>?
        init(list: IdentifiedArrayOf<HistoryFeature.State> = [], status: Result<Bool, HistoryError>? = nil) {
            self.list = list
           
            self.status = status
        }
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction {
            case onLoad
            case onRemoveAll
        }
        
        enum DelegateAction {
            case selected(WorkoutHistoryItem)
        }
        
        @CasePathable
        enum BusinessAction {
            case list(IdentifiedActionOf<HistoryFeature>)
            case removeAll
            case load
            case success([RecordedWorkout])
            case error
        }
        
        case view(ViewAction)
        case delegate(DelegateAction)
        case business(BusinessAction)
        
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
                
            case let .view(action):
                return _reduce(into: &state, action: action)
                
            case let .delegate(action):
                return _reduce(into: &state, action: action)
                
            case let .business(action):
                return _reduce(into: &state, action: action)
            }
        }
        .forEach(\.list, action: \.business.list) {
            HistoryFeature()
        }
    }
    
    private func _reduce(into state: inout State, action: Action.ViewAction) -> Effect<Action> {
        switch action {
        case .onLoad:
            return .send(.business(.load))
            
        case .onRemoveAll:
            return .send(.business(.removeAll))
        }
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
        switch action {
        case .load:
            return .run { send in
                if let urlList = RecorderWrapper().getIntermediateWorkoutsFromDisk() {
                    let workoutList = urlList.compactMap { url in
                        RecordedWorkout.fromUrl(url: url, name: url.lastPathComponent.split(separator: "-").first?.description ?? "NA")
                    }
                    await send(.business(.success(workoutList)))
                } else {
                    await send(.business(.error))
                }
            }
            
        case .removeAll:
            RecorderWrapper().recorderRemoveAll()
            return .send(.business(.load))
            
        case .success(let list):
            var i = 0
            let items = list.map { item in
                i += 1
                return HistoryFeature.State(item: WorkoutHistoryItem(idx: i, data: item))
            }
            state.list = .init(IdentifiedArray(uniqueElements: items.reversed()))
            state.status = .success(!items.isEmpty)
            return .none
            
        case .error:
            state.status = .failure(.error)
            return .none
            
        case .list(.element(_, action: .delegate(let delegateAction))):
            switch delegateAction {
                
            case .selected(let item):
                return .send(.delegate(.selected(item)))
            }
            
        case .list:
            return .none
        }
    }
}

enum HistoryError: Error {
    case error
}

struct WorkoutHistoryItem: Identifiable, Equatable {
    var id: String {
        return "\(idx)"
    }
    
    let idx: Int
    let data: RecordedWorkout
}

import ComposableArchitecture

@Reducer
struct HistoryFeature: Reducer {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let item: WorkoutHistoryItem
        var id: WorkoutHistoryItem.ID {
            return item.id
        }
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction: Equatable {
            case onSelected
        }
        
        enum DelegateAction: Equatable {
            case selected(WorkoutHistoryItem)
        }
        
        enum BusinessAction: Equatable {
            
        }
        
        case view(ViewAction)
        case delegate(DelegateAction)
        case business(BusinessAction)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return _reduce(into: &state, action: action)
                
            case let .delegate(action):
                return _reduce(into: &state, action: action)
                
            case let .business(action):
                return _reduce(into: &state, action: action)
            }
        }
    }
    
    private func _reduce(into state: inout State, action: Action.ViewAction) -> Effect<Action> {
        switch action {
        case .onSelected:
            return .send(.delegate(.selected(state.item)))
        }
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
        return .none
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
    }
}
