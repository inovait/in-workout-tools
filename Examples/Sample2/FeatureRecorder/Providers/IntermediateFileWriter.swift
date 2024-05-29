//
//  FitIntermediateFileWriter.swift
//
//  Created by Luka Kit on 11/07/2023.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation
import CommonModels

class IntermediateFileWriter: IntermediateFileProtocol {
    
    let fileUrl: URL
    let fileName: String
    let fitFileName: String
    private var fileHandle: FileHandle? = nil
    var wasStarted = false
    
    init(fileName: String) {
        self.fileName = fileName
        self.fitFileName = fileName.replacingOccurrences(of: ".txt", with: ".fit")
        let directory = StorageProviderImpl._intermediateWorkoutsDirectory()
        fileUrl = directory.appendingPathComponent(fileName)
        let input = "\(IntermediateFileKeywords.version.rawValue),1\n"
        writeToFile(input)
    }
    
    func start(date: Date) {
        let input = "\(IntermediateFileKeywords.start.rawValue),\(Int32(date.timeIntervalSince1970))\n"
        writeToFile(input)
        wasStarted = true
    }
    
    func ping(workoutDuration: Int) {
        let input = "\(IntermediateFileKeywords.ping.rawValue),\(workoutDuration.description)\n"
        writeToFile(input)
    }
    
    func addUser(gender: Gender?, age: Int?, height: Double?, weight: Double?) {
        let input = "\(IntermediateFileKeywords.user.rawValue),\(gender?.value ?? ""),\(age?.description ?? ""),\(height?.description ?? ""),\(weight?.description ?? "")\n"
        writeToFile(input)
    }
    
    func addHrmRecord(hr: Int, date: Date, workoutDuration: Int) {
        let input = "\(IntermediateFileKeywords.hrm.rawValue),\(Int32(date.timeIntervalSince1970)),\(hr.description),\(workoutDuration.description)\n"
        writeToFile(input)
    }
    
    func addImpactRecord(impact: Int, date: Date, workoutDuration: Int) {
        let input = "\(IntermediateFileKeywords.impact.rawValue),\(Int32(date.timeIntervalSince1970)),\(impact.description),\(workoutDuration.description)\n"
        writeToFile(input)
    }
    
    func addRoundStarted(date: Date, roundIndex: Int, workoutDuration: Int, isRest: Bool, exerciseName: String) {
        let input = "\(IntermediateFileKeywords.roundStart.rawValue),\(Int32(date.timeIntervalSince1970)),\(roundIndex.description),\(workoutDuration.description),\(isRest ? 1 : 0),\(exerciseName)\n"
        writeToFile(input)
    }
    
    func addRoundFinished(date: Date, roundIndex: Int, workoutDuration: Int, isRest: Bool, exerciseName: String) {
        let input = "\(IntermediateFileKeywords.roundEnd.rawValue),\(Int32(date.timeIntervalSince1970)),\(roundIndex.description),\(workoutDuration.description),\(isRest ? 1 : 0),\(exerciseName)\n"
        writeToFile(input)
    }
    
    func addSession(date: Date, isStart: Bool, workoutDuration: Int, roundDuration: Int, sessionName: String) {
        var input: String
        if isStart {
            input = "\(IntermediateFileKeywords.sessionStart.rawValue),\(Int32(date.timeIntervalSince1970)),\(workoutDuration.description),\(sessionName)\n"
        } else {
            input = "\(IntermediateFileKeywords.sessionEnd.rawValue),\(Int32(date.timeIntervalSince1970)),\(workoutDuration.description),\(roundDuration.description),\(sessionName)\n"
        }
        writeToFile(input)
    }
    
    func addPause(date: Date) {
        let input = "\(IntermediateFileKeywords.pause.rawValue),\(Int32(date.timeIntervalSince1970))\n"
        writeToFile(input)
    }
    
    func addResume(date: Date) {
        let input = "\(IntermediateFileKeywords.resume.rawValue),\(Int32(date.timeIntervalSince1970))\n"
        writeToFile(input)
    }
    
    func addSkipBack(date: Date) {
        let input = "\(IntermediateFileKeywords.skipBack.rawValue),\(Int32(date.timeIntervalSince1970))\n"
        writeToFile(input)
    }
    
    func stop(date: Date, totalTimerTime: Int, finalRoundDuration: Int) {
        let input = "\(IntermediateFileKeywords.end.rawValue),\(Int32(date.timeIntervalSince1970)),\(totalTimerTime.description),\(finalRoundDuration.description)\n"
        writeToFile(input)
        fileHandle?.closeFile()
        fileHandle = nil
        wasStarted = false
    }
    
    internal func writeToFile(_ input: String) {
        assert(Thread.isMainThread)
        let inputData = input.data(using: String.Encoding.utf8)
        if let inputData {
            do {
                if FileManager.default.fileExists(atPath: fileUrl.path) {
                    if let fileHandle {
                        fileHandle.seekToEndOfFile()
                        fileHandle.write(inputData)
                    }
                } else {
                    try input.write(to: fileUrl, atomically: false, encoding: .utf8)
                    fileHandle = try? FileHandle(forWritingTo: fileUrl)
                }
            }
            catch {
                assertionFailure("Unable to write in the file")
            }
        } else {
            assertionFailure("fileUri or inputData missing")
        }
    }
    
    func removeAll() {
        let directory = StorageProviderImpl._intermediateWorkoutsDirectory()
        do {
            try FileManager.default.removeItem(at: directory)
        } catch {
            // do nothing
        }
    }
}
