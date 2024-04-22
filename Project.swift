import ProjectDescription

let project = Project(
    name: "InWorkoutTools",
    targets: [
        .target(
            name: "InWorkoutTools",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.InWorkoutTools",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["InWorkoutTools/Sources/**"],
            resources: ["InWorkoutTools/Resources/**"],
            dependencies: [
                .framework(path: "SDK/CommonTca.framework", status: .required, condition: nil),
                .framework(path: "SDK/CommonModels.framework", status: .required, condition: nil),
                .framework(path: "SDK/FeatureExercise.framework", status: .required, condition: nil),
                .framework(path: "SDK/FeatureRecorder.framework", status: .required, condition: nil),
                .framework(path: "SDK/FeatureTime.framework", status: .required, condition: nil),
                .framework(path: "SDK/FeatureVideo.framework", status: .required, condition: nil),
                .framework(path: "SDK/FeatureWorkout.framework", status: .required, condition: nil),
                .external(name: "ComposableArchitecture"),
            ]
        ),
        .target(
            name: "InWorkoutToolsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.InWorkoutToolsTests",
            infoPlist: .default,
            sources: ["InWorkoutTools/Tests/**"],
            resources: [],
            dependencies: [.target(name: "InWorkoutTools")]
        ),
    ]
)
