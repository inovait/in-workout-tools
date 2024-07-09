//
//  PersistanceReaderKey.swift
//  FeatureModels
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
import ComposableArchitecture
import WorkoutFramework
import CommonModels

public extension PersistenceKey where Self == FileStorageKey<[Exercise]> {
    static var workouts: Self {
        fileStorage(builtWorkoutsFile)
    }
}

private func _builtWorkoutsDirectory() -> URL {
    let folder = "BuiltWorkoutsFolder"
    let documentDirectory = NSURL(
        fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    )
    if let dirPath = documentDirectory.appendingPathComponent(folder, isDirectory: true), !FileManager.default.fileExists(atPath: dirPath.path) {
        do {
            try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            assertionFailure("\(error)")
        }
    }
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory.appendingPathComponent(folder, isDirectory: true)
}

private let builtWorkoutsFile = _builtWorkoutsDirectory().appendingPathComponent("builtWorkoutsFile")
