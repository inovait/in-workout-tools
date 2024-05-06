import ProjectDescription

let project = Project(
    name: "InWorkoutTools",
    targets: [
        .target(
            name: "InWorkoutTools",
            destinations: .iOS,
            product: .app,
            bundleId: "com.inova.InWorkoutTools",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["InWorkoutTools/Sources/**"],
            resources: ["InWorkoutTools/Resources/**"],
            dependencies: [
                .xcframework(path: "SDK/CommonTca.xcframework", status: .required, condition: nil),
                .xcframework(path: "SDK/CommonModels.xcframework", status: .required, condition: nil),
                .xcframework(path: "SDK/FeatureExercise.xcframework", status: .required, condition: nil),
                .xcframework(path: "SDK/FeatureRecorder.xcframework", status: .required, condition: nil),
                .xcframework(path: "SDK/FeatureTime.xcframework", status: .required, condition: nil),
                .xcframework(path: "SDK/FeatureVideo.xcframework", status: .required, condition: nil),
                .xcframework(path: "SDK/FeatureWorkout.xcframework", status: .required, condition: nil),
                .external(name: "ComposableArchitecture"),
                .target(name: "SomeFramework")
            ]
        ),
        .target(
            name: "InWorkoutToolsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.inova.InWorkoutToolsTests",
            infoPlist: .default,
            sources: ["InWorkoutTools/Tests/**"],
            resources: [],
            dependencies: [.target(name: "InWorkoutTools")]
        ),
        .target(
            name: "SomeFramework",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.inova.SomeFramework",
            deploymentTargets: DeploymentTargets.iOS("16.0"),
            infoPlist: .default,
            sources: ["SomeFramework/Sources/**"],
            resources: []
        )
    ]
)
