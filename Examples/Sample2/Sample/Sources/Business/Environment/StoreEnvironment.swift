//
//  StoreEnvironment.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 23. 02. 24.
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

private(set) var _store: StoreOf<ProjectNavigationFeature> = {
    
    let store: StoreOf<ProjectNavigationFeature> = .init(initialState: ProjectNavigationFeature.State(root: .home(.init()))) {
        ProjectNavigationFeature()
    }

    return store
}()

struct ProjectNavigationEnvironmentKey: EnvironmentKey {

    static var defaultValue: StoreOf<ProjectNavigationFeature> = _store
}

extension EnvironmentValues {

    var pathStore: StoreOf<ProjectNavigationFeature> {
        get { self[ProjectNavigationEnvironmentKey.self] }
        set { self[ProjectNavigationEnvironmentKey.self] = newValue }
    }
}
