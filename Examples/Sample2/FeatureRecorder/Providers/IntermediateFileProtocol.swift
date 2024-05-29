//
//  FitIntermediateFileProtocol.swift
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

protocol IntermediateFileProtocol {
    var wasStarted: Bool { get }
    var fileUrl: URL { get }
    
    /// start
    /// - Parameter date: start date
    func start(date: Date)
    /// stop
    /// - Parameters:
    ///   - date: end date
    ///   - totalTimerTime: total workout time
    ///   - finalRoundDuration: last round time
    func stop(date: Date, totalTimerTime: Int, finalRoundDuration: Int)
    
    /// add user
    /// - Parameters:
    ///   - gender: gnder
    ///   - age: age
    ///   - height: height in cm
    ///   - weight: weight in kg
    func addUser(gender: Gender?, age: Int?, height: Double?, weight: Double?)
    
    func addHrmRecord(hr: Int, date: Date, workoutDuration: Int)
    func addImpactRecord(impact: Int, date: Date, workoutDuration: Int)
    
    /// round started
    /// - Parameters:
    ///   - date: date
    ///   - roundIndex: round index
    ///   - workoutDuration: total workout time at this point
    ///   - isRest: is exercise a rest
    ///   - exerciseName: exercise name
    func addRoundStarted(date: Date, roundIndex: Int, workoutDuration: Int, isRest: Bool, exerciseName: String)
    /// round finished
    /// - Parameters:
    ///   - date: date
    ///   - roundIndex: round index
    ///   - workoutDuration: total workout time at this point
    ///   - isRest: is exercise a rest
    ///   - exerciseName: exercise name
    func addRoundFinished(date: Date, roundIndex: Int, workoutDuration: Int, isRest: Bool, exerciseName: String)
    
    /// Session represents a parent exercise which contains multiple sub exercises
    /// - Parameters:
    ///   - date: date
    ///   - isStart: is start
    ///   - workoutDuration: total workout time at this point
    ///   - roundDuration: duration of session - on session start this is 0
    ///   - sessionName: session name stored usally in exercise.name
    func addSession(date: Date, isStart: Bool, workoutDuration: Int, roundDuration: Int, sessionName: String)
    func addPause(date: Date)
    func addResume(date: Date)
    
    /// Used for recovery, in case app crashes we can resume to the last ping time
    /// - Parameter workoutDuration: total workout time at this point
    func ping(workoutDuration: Int)
    
    func removeAll()
}

class FitIntermediateFileWriterMock: IntermediateFileWriter {
    var fileInputs = [String]()
    
    override internal func writeToFile(_ input: String) {
        fileInputs.append(input)
    }
}
