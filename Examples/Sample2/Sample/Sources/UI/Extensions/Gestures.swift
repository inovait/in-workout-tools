//
//  Gestures.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 25. 03. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import SwiftUI

extension Gesture where Self == DragGesture {

    static func swipeLeftGesture(action: @escaping () -> Void) -> _EndedGesture<DragGesture> {
        return DragGesture(minimumDistance: 50, coordinateSpace: .local)
            .onEnded { gesture in
                guard gesture.translation.width > 0 else { return }
                action()
            }
    }

    static func swipeRightGesture(action: @escaping () -> Void) -> _EndedGesture<DragGesture> {
        return DragGesture(minimumDistance: 50, coordinateSpace: .local)
            .onEnded { gesture in
                guard gesture.translation.width < 0 else { return }
                action()
            }
    }
}
