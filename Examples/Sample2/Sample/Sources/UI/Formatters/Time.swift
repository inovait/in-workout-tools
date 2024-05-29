//
//  Time.swift
//  InWorkoutTools
//
//  Created by Peter Muraus on 21. 03. 24.
//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation

public func toInWorkoutDurationOrNil(duration: TimeInterval?) -> String? {
    guard let duration else { return nil }
    
    return toInWorkoutDuration(duration: duration)
}
/// duration format, does not dispaly zero value, so in 22min 0s seconds wont be displayed
/// - duration: in miliseconds
/// - Returns: 1h 22min 4s
public func toDurationLongString(duration: TimeInterval) -> String {
    let totSeconds = duration.toSeconds()
    let totMinutes = duration.toSeconds() / 60
    let hours: Int = totMinutes / 60
    let minutes: Int = totMinutes - (hours * 60)
    let seconds: Int = totSeconds - (totMinutes * 60)
    
    var retString = ""
    if hours != 0 {
        retString = "\(hours)h"
    }
    if minutes != 0 {
        if !retString.isEmpty {
            retString += " "
        }
        retString += "\(minutes)m"
    }
    if seconds != 0 {
        if !retString.isEmpty {
            retString += " "
        }
        retString += "\(seconds)s"
    }
    return retString
}

public func toInWorkoutDuration(duration: TimeInterval) -> String {
    let durationInSeconds = Double(duration.toSeconds())
    let formatter = DateComponentsFormatter()
    formatter.zeroFormattingBehavior = .pad
    if (durationInSeconds >= 3600) {
        formatter.allowedUnits = [.hour, .minute, .second]
    } else {
        formatter.allowedUnits = [.minute, .second]
    }
     
    return formatter.string(from: durationInSeconds) ?? ""
}

public func toLongDateTime(timestampInSeconds: TimeInterval) -> String {
    return Date(timeIntervalSince1970: timestampInSeconds).toLongDateTime()
}

extension Date {
    func toLongDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: self)
    }
}

extension TimeInterval {
    public func toSeconds() -> Int {
        return Int(self / 1000)
    }
}
