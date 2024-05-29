//
//  Reps.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 26. 03. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation

func toReps(reps: Int?) -> String? {
    guard let reps, reps != 0 else { return nil }
    
    if reps == 1 {
        return "1 rep"
    }
    
    return "\(reps) reps"
}
