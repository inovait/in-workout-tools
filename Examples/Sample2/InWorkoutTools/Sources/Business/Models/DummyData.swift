//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import SwiftUI
import CommonModels

public struct DummyData {
    public init() {}
    public let exampleMedia: [Media] = [
        Media(url: URL(string: "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg"), type: "image/jpg"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"), type: "video/mp4", loopVideo: true),
        Media(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Rotating_earth_%28large%29.gif/200px-Rotating_earth_%28large%29.gif"), type: "image/gif"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"), type: "video/mp4"),
        Media(url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/2024-ferrari-sf90-xx-stradale-122-654a66978f827.jpg?crop=0.601xw:0.798xh;0.232xw,0.128xh&resize=768:*"), type: "image/jpg"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"), type: "video/mp4", loopVideo: true),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"), type: "video/mp4"),
        Media(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Rotating_earth_%28large%29.gif/200px-Rotating_earth_%28large%29.gif"), type: "image/gif"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"), type: "video/mp4"),
        Media(url: URL(string: "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg"), type: "image/jpg"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"), type: "video/mp4"),
        Media(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Rotating_earth_%28large%29.gif/200px-Rotating_earth_%28large%29.gif"), type: "image/gif"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"), type: "video/mp4"),
        Media(url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/2024-ferrari-sf90-xx-stradale-122-654a66978f827.jpg?crop=0.601xw:0.798xh;0.232xw,0.128xh&resize=768:*"), type: "image/jpg"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"), type: "video/mp4", loopVideo: true),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"), type: "video/mp4"),
        Media(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Rotating_earth_%28large%29.gif/200px-Rotating_earth_%28large%29.gif"), type: "image/gif"),
        Media(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"), type: "video/mp4", loopVideo: true)
    ]

    public let exerciseNames = [
        "Burpee Box Jumps", "Kettlebell Swings", "Pull-Up Variations", "Medicine Ball Throws", "Jump Rope Intervals",
        "Squat Jumps", "Deadlifts", "Push Presses", "Rowing Sprints", "Wall Balls", "Thrusters", "Handstand Push-Ups",
        "Russian Twists", "Plank Variations", "Lunges with Weights", "Box Step-Ups", "Dumbbell Snatches", "Mountain Climbers",
        "Toes-to-Bar", "Bench Presses", "Overhead Lunges", "Power Cleans", "Dips", "Battle Rope Slams", "Plyometric Push-Ups",
        "Sled Drags", "Squat Cleans", "Rope Climbs", "Renegade Rows", "Burpee Pull-Ups", "Jumping Lunges", "Wall Walks",
        "Sandbag Carries", "Farmers Walks", "Box Jumps", "Pistol Squats", "Inverted Rows", "Hand Release Push-Ups",
        "Turkish Get-Ups", "Goblet Squats", "Bear Crawls", "Assault Bike Sprints", "Plate Ground to Overhead",
        "Sledgehammer Strikes", "Dumbbell Lunges", "Ring Muscle-Ups", "Dumbbell Rows", "Russian Kettlebell Swings"
    ]
    
    public let workoutNames = [
        "Intensity Boost",
        "Endurance Challenge",
        "Fitness Fusion",
        "Power Surge",
        "Strength Quest",
        "Energy Explosion",
        "Cardio Charge",
        "Agility Adventure",
        "Muscle Mastery",
        "Balance Blitz",
        "Speed Sprint",
        "Wellness Warrior",
        "Dynamic Dash",
        "Stamina Stride",
        "Body Blast",
        "Revitalize Routine",
        "Performance Pursuit",
        "Movement Marvel"
    ]
    
    public let emilyVideos = [
        //0
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fkneeling_push_ups_low.mp4"), type: "video/mp4", loopVideo: true),
        //1
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fsquats_low.mp4"), type: "video/mp4", loopVideo: true),
        //2
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fbicycle_crunches_low.mp4"), type: "video/mp4", loopVideo: true),
        //3
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fin_out_jump_low.mp4"), type: "video/mp4", loopVideo: true),
        //4
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Flunges_low.mp4"), type: "video/mp4", loopVideo: true),
        //5
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fvsit_leg_extensions_low.mp4"), type: "video/mp4", loopVideo: true),
        //6
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FIncline%20Push-Up.mp4"), type: "video/mp4", loopVideo: true),
        //7
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FDeadbug%20Hold.mov"), type: "video/mov", loopVideo: true),
        //8
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2Fpullups.mp4"), type: "video/mp4", loopVideo: true),
        //9
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FThe%20Burpee.mp4"), type: "video/mp4", loopVideo: true),
        
        //10
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fmountainclimbers.mp4"), type: "video/mp4", loopVideo: true),
        
        //11
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fstepups.mp4"), type: "video/mp4", loopVideo: true),
        
        //12
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Freverselunges.mp4"), type: "video/mp4", loopVideo: true),
        
        //13
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2FDips.mp4"), type: "video/mp4", loopVideo: true),
        
        //14
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2FThe%20Chin-Up.mp4"), type: "video/mp4", loopVideo: true),
        
        //15
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2FDiamond%20Push%20Up.mp4"), type: "video/mp4", loopVideo: true),
        
        //16
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2FInverted%20Row.mp4"), type: "video/mp4", loopVideo: true),
        
        //17
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2FChair%20Dips.mp4"), type: "video/mp4", loopVideo: true),
        
        //18
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FpublishedPacks%2Fi6wMjLWgRK7ZNoJyauWB%2Frevisions%2F67%2Fmedia%2FNeutral%20Grip%20Pull-Up.mp4"), type: "video/mp4", loopVideo: true),
        
        //19
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FRussian%20Twists.mov"), type: "video/mov", loopVideo: true),
        
        //20
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FPlank%20w%20Single%20Leg%20Raises.mov"), type: "video/mov", loopVideo: true),
        
        //21
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FFlutter%20Kicks.mov"), type: "video/mov", loopVideo: true),
        
        //22
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2FHindu%20Push-ups.mov"), type: "video/mov", loopVideo: true),
        
        //23
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fhigh-knees-icegif.gif"), type: "image/gif", loopVideo: true),
        
        //24
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2FV-sit%20Knee%20Tuck.mov"),  type: "video/mov", loopVideo: true),
        
        //25
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2FPlank.mov"), type: "video/mov", loopVideo: true),
        
        //26
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2FHigh%20Plank%20Shoulder%20Taps.mov"), type: "video/mov", loopVideo: true),
        
        //27
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fwide-arm-push-ups.gif"), type: "image/gif", loopVideo: true),
        
        //28
        Media(url: URL(string: "https://storage.googleapis.com/impact-wrap-one-dev.appspot.com/gymStorage%2Fimpact-wrap%2Fpacks%2Fi6wMjLWgRK7ZNoJyauWB%2Fmedia%2Fvsit_leg_extensions_low.mp4"), type: "video/mp4", loopVideo: true)
    ]
}
