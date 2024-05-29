//
//  StorageProviderImpl.swift
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

public class StorageProviderImpl: StorageProvider {
    
    public init() {}
    
    public func removeAllFromDisk() {
        DispatchQueue.global().async {
            let workoutDirectory = Self._workoutsDirectory()
            if let workoutDirectoryUrl = URL(string: workoutDirectory) {
                let fileURLs = try? FileManager.default.contentsOfDirectory(at: workoutDirectoryUrl, includingPropertiesForKeys: nil)

                for fileURL in fileURLs ?? [] {
                    if FileManager.default.fileExists(atPath: fileURL.path) {
                        do {
                            try FileManager.default.removeItem(at: fileURL)
                        } catch {
                            assertionFailure("\(error)")
                        }
                    }
                }
            }
        }
    }
        
    public func getWorkoutsFromDisk() -> [URL]? {
        let workoutDirectory = Self._workoutsDirectory()
        guard let workoutDirectoryUrl = URL(string: workoutDirectory) else { return nil }
        
        let fileManager = FileManager.default
        do {
            let _fileURLs = try fileManager.contentsOfDirectory(at: workoutDirectoryUrl, includingPropertiesForKeys: nil)
            
            let fileURLs = _fileURLs.map { url in
                (url, (try? url.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate ?? Date.distantPast)
            }
                .sorted(by: { $0.1 < $1.1 }) // sort ascending modification dates
                .map { $0.0 } // extract file names
            
            return fileURLs
        } catch {
            return nil
        }
    }
    
    public func getIntermediateWorkoutsFromDisk() -> [URL]? {
        let workoutDirectory = Self._intermediateWorkoutsDirectory()
        
        let fileManager = FileManager.default
        
        do {
            let _fileURLs = try fileManager.contentsOfDirectory(at: workoutDirectory, includingPropertiesForKeys: nil)
            
            let fileURLs = _fileURLs.map { url in
                (url, (try? url.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate ?? Date.distantPast)
            }
                .sorted(by: { $0.1 < $1.1 }) // sort ascending modification dates
                .map { $0.0 } // extract file names
            
            return fileURLs
        } catch {
            return nil
        }
    }
    
    public func removeWorkoutFromDisk(_ filePath: URL) {
        DispatchQueue.global().async {
            if FileManager.default.fileExists(atPath: filePath.path) {
                do {
                    try FileManager.default.removeItem(at: filePath)
                } catch {
                    assertionFailure("\(error)")
                }
            }
        }
    }
    
    static func _workoutsDirectory() -> String {
        let folder = "WorkoutFiles"
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

        let documentsPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first ?? ""
        return documentsPathString + "/WorkoutFiles/"
    }
    
    static func _intermediateWorkoutsDirectory() -> URL {
        let folder = "IntermediateWorkoutFiles"
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
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentsPath[0].appendingPathComponent(folder)
    }
    
    static func _workoutsDirectoryForMultipart() -> URL {
        let folder = "WorkoutFiles"
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
    
    private static func _builtWorkoutsDirectory() -> URL {
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
    
    public static let builtWorkoutsFile = _builtWorkoutsDirectory().appendingPathComponent("builtWorkoutsFile")
}
