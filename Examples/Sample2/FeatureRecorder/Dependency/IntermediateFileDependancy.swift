//
//  IntermediateFileDependancy.swift
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
import Combine
import ComposableArchitecture

// FIXME: SENDABLE!!
// FIXME: Identifiable byid
public struct IntermediateFileDependancy {
    /// Prepare workout file with workout name
    public var prepare: (String) -> Void
    
    public var pause: (Date) -> Void
    public var resume: (Date) -> Void
    /// date, workoutdurationSeconds: Int, sessionName
    public var sessionStarted: (Date, Int, String) -> Void
    /// date, workoutdurationSeconds: Int, roundDuration - duration of session, sessionName
    public var sessionFinished: (Date, Int, Int, String) -> Void
    /// date: Date, roundIndex: Int, workoutDurationInSeconds: Int, isRest: Bool, exerciseName: String
    public var roundStarted: (Date, Int, Int, Bool, String) -> Void
    /// date: Date, roundIndex: Int, workoutDurationInSeconds: Int, isRest: Bool, exerciseName: String
    public var roundFinished: (Date, Int, Int, Bool, String) -> Void
    
    public var end: (Date, Int, Int) -> String
    
    public var removeAll: () -> Void
}

public struct IntermediateFileDependancyKey: DependencyKey {
    
    public static var liveValue: IntermediateFileDependancy {
        var intermediateFileWriter: IntermediateFileProtocol?
        
        return .init { workoutName in
            print("IntermediateFileDependancy-> Init \(workoutName)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let name = "\(workoutName)-\(dateFormatter.string(from: Date()))-\(Date().timeIntervalSince1970)"
            intermediateFileWriter = IntermediateFileWriter(fileName: name)
        } pause: { date in
            print("IntermediateFileDependancy-> pause")
            intermediateFileWriter!.addPause(date: date)
        } resume: { date in
            print("IntermediateFileDependancy-> resume")
            intermediateFileWriter!.addResume(date: date)
        } sessionStarted: { date, workoutDuration, sessionName in
            if !intermediateFileWriter!.wasStarted {
                print("IntermediateFileDependancy-> start")
                intermediateFileWriter!.start(date: date)
            }
            print("IntermediateFileDependancy-> ++ sessionStarted \(sessionName)")
            intermediateFileWriter!.addSession(date: date, isStart: true, workoutDuration: workoutDuration, roundDuration: 0, sessionName: sessionName)
        } sessionFinished: { date, workoutDuration, roundDuration, sessionName in
            print("IntermediateFileDependancy-> -- sessionFinished \(sessionName)")
           intermediateFileWriter!.addSession(date: date, isStart: false, workoutDuration: workoutDuration, roundDuration: roundDuration, sessionName: sessionName)
        } roundStarted: { date, roundIndex, workoutDurationInSeconds, isRest, exerciseName in
            if !intermediateFileWriter!.wasStarted {
                print("IntermediateFileDependancy-> start")
                intermediateFileWriter!.start(date: date)
            }
            print("IntermediateFileDependancy-> + addRoundStarted \(exerciseName) \(roundIndex) w \(workoutDurationInSeconds)")
            intermediateFileWriter!.addRoundStarted(date: date, roundIndex: roundIndex, workoutDuration: workoutDurationInSeconds, isRest: isRest, exerciseName: exerciseName)
        } roundFinished: { date, roundIndex, workoutDurationInSeconds, isRest, exerciseName in
            print("IntermediateFileDependancy-> - addRoundFinished \(exerciseName) \(roundIndex)")
            intermediateFileWriter!.addRoundFinished(date: date, roundIndex: roundIndex, workoutDuration: workoutDurationInSeconds, isRest: isRest, exerciseName: exerciseName)
        } end: { date, totalTimerTime, finalRoundDuration in
            print("IntermediateFileDependancy-> stop")
            intermediateFileWriter!.stop(date: date, totalTimerTime: totalTimerTime, finalRoundDuration: finalRoundDuration)
            let fileUrl = intermediateFileWriter!.fileUrl.absoluteString
            intermediateFileWriter = nil
            return fileUrl
        } removeAll: {
            print("IntermediateFileDependancy-> removeAll")
            IntermediateFileWriter(fileName: "").removeAll()
        }
    }
    
    public static var testValue: IntermediateFileDependancy {
        return .init { _ in }
            pause: { _ in }
            resume: { _ in }
            sessionStarted: { _,_,_ in }
            sessionFinished: { _,_,_,_ in }
            roundStarted: { _,_,_,_,_ in }
            roundFinished: { _,_,_,_,_ in }
            end: { _,_,_ in "testFilePath" }
            removeAll: {}
    }
}

extension DependencyValues {
    public var recordFile: IntermediateFileDependancy {
        get { self[IntermediateFileDependancyKey.self] }
        set { self[IntermediateFileDependancyKey.self] = newValue }
    }
}
