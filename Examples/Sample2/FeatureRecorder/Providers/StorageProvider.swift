//
//  StorageProvider.swift
//  FeatureRecorder
//
//  Created by Peter Muraus on 27. 02. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation

public protocol StorageProvider {
    func removeAllFromDisk()
    func getWorkoutsFromDisk() -> [URL]?
    func getIntermediateWorkoutsFromDisk() -> [URL]?
    func removeWorkoutFromDisk(_ filePath: URL)
}
