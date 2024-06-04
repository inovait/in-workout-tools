//
//  RecorderWorkout.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 11. 04. 24.
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

struct RecordedWorkout: Equatable {
    let timestamp: TimeInterval
    let duration: Int
    let name: String
    let breakdown: [RecordedBreakdownItem]
    
    var exercisesDisplay: String {
        let nbr = breakdown.filter { item in
            item.type == .roundEnded
        }.count
        if nbr == 1 {
            return "\(nbr) exercise"
        }
        return "\(nbr) exercises"
    }
}

struct RecordedBreakdownItem: Equatable, Hashable {
    let roundIdx: Int?
    let timestamp: Int
    let type: RecordedBreakdownType
    let duration: Int
    let exerciseName: String?
}

enum RecordedBreakdownType: Equatable {
    case start
    case sessionStarted
    case sessionEnded
    case roundStarted
    case roundEnded
    case stop
}

extension [RecordedBreakdownItem] {
    func toExercises() -> [RepsExercise] {
        var i = 0
        var sessions: [RepsExercise] = []
        var exercises: [RepsExercise] = []
        var records: [Int: RecordedBreakdownItem] = [:]
        forEach { item in
            i += 1
            print("-> \(item.type) \(item.exerciseName) \(item.roundIdx)")
            switch item.type {
            case .sessionEnded:
                let removed = exercises.removeLast()
                sessions.append(RepsExercise(id: i.description, name: removed.name, type: removed.type, durationInMillis: removed.durationInMillis, idx: removed.idx, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: exercises))
                exercises = []

            case .roundEnded:
                let startTimestamp = records[item.roundIdx ?? 0]?.timestamp
                let duration = startTimestamp != nil ? item.timestamp - (startTimestamp ?? 0) : 0
                exercises.append(RepsExercise(id: i.description, name: item.exerciseName ?? "", type: .exercise, durationInMillis: duration.toMillis(), idx: item.roundIdx ?? 0, exerciseRepetition: 0, reps: 0, loopSubExercises: false, canSkipExercise: false, subExercises: []))
            default:
                _ = "do nothing"
            }
            records[item.roundIdx ?? 0] = item
        }

        return sessions
    }
    
    
}
extension Int {
    func toMillis() -> TimeInterval {
        return Double(self * 1000)
    }
}

extension RecordedWorkout {
    static func fromUrl(url: URL, name: String) -> RecordedWorkout? {
        do {
            var startTime: TimeInterval = 0
            var duration = 0
            var breakdown: [RecordedBreakdownItem] = []
            
            let content = try String(contentsOf: url, encoding: .utf8)
            let lines = content.split(separator: "\n")
            for line in lines {
                let commands = line.split(separator: ",")
                switch commands.first?.description {
                case IntermediateFileKeywords.start.rawValue:
                    startTime = TimeInterval(commands[1]) ?? 0.0
                    
                case IntermediateFileKeywords.roundStart.rawValue:
                    breakdown.append(RecordedBreakdownItem(roundIdx: commands[2].toIntOrZero(), timestamp: commands[1].toIntOrZero(), type: .roundStarted, duration: commands.getOrNil(3).toIntOrZero(), exerciseName: commands.getOrNil(5).toString()))
                    
                case IntermediateFileKeywords.roundEnd.rawValue:
                    breakdown.append(RecordedBreakdownItem(roundIdx: commands[2].toIntOrZero(), timestamp: commands[1].toIntOrZero(), type: .roundEnded, duration: commands.getOrNil(3).toIntOrZero(), exerciseName: commands.getOrNil(5).toString()))
                                    
                case IntermediateFileKeywords.sessionStart.rawValue:
                    breakdown.append(RecordedBreakdownItem(roundIdx: nil, timestamp: commands[1].toIntOrZero(), type: .sessionStarted, duration: 0, exerciseName: commands.getOrNil(3).toString()))
                                    
                case IntermediateFileKeywords.sessionEnd.rawValue:
                    breakdown.append(RecordedBreakdownItem(roundIdx: nil, timestamp: commands[1].toIntOrZero(), type: .sessionEnded, duration: commands.getOrNil(3).toIntOrZero(), exerciseName: commands.getOrNil(4).toString()))
                    
                case IntermediateFileKeywords.end.rawValue:
                    duration = commands[2].toIntOrZero()
                    
                default:
                    var _ = "ignore"
                }
            }
            
            return RecordedWorkout(timestamp: startTime, duration: duration, name: name, breakdown: breakdown)
        } catch {
            // ignore
        }
        return nil
    }
}

extension Substring {
    func toIntOrZero() -> Int {
        return Int(self.description) ?? 0
    }
}

extension Substring? {
    func toIntOrZero() -> Int {
        return self != nil ? self!.toIntOrZero() : 0
    }
    func toString() -> String {
        return self?.description ?? ""
    }
    
}
extension [Substring.SubSequence] {
    func getOrNil(_ idx: Int) -> Substring? {
        return self.count > idx ? self[idx] : nil
    }
    
}
