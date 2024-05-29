//
//  TCAFeatureAction.swift
//  CommonTca
//
//  Created by Peter Muraus on 17. 02. 24.
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

public protocol TCAFeatureAction {
    associatedtype ViewAction
    associatedtype DelegateAction
    associatedtype BusinessAction
    
    static func view(_: ViewAction) -> Self
    static func delegate(_: DelegateAction) -> Self
    static func business(_: BusinessAction) -> Self
}

@Reducer
struct DummyPeroReducer: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action: TCAFeatureAction {
        
        @CasePathable
        enum ViewAction: Equatable {
            
        }
        
        enum DelegateAction: Equatable {
            
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
    }
    
    private func _reduce(into state: inout State, action: Action.DelegateAction) -> Effect<Action> {
    }
    
    private func _reduce(into state: inout State, action: Action.BusinessAction) -> Effect<Action> {
    }
}
