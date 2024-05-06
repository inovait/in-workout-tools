// swift-tools-version:5.8.1
import PackageDescription


let package = Package(
    name: "InWorkoutTools",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CommonTca",
            targets: ["CommonTca"]),
        .library(
            name: "CommonModels",
            targets: ["CommonModels"]),
        .library(
            name: "FeatureExercise",
            targets: ["FeatureExercise"]),
        .library(
            name: "FeatureRecorder",
            targets: ["FeatureRecorder"]),
        .library(
            name: "FeatureTime",
            targets: ["FeatureTime"]),
        .library(
            name: "FeatureVideo",
            targets: ["FeatureVideo"]),
        .library(
            name: "FeatureWorkout",
            targets: ["FeatureWorkout"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(name: "CommonTca", path: "SDK/CommonTca.xcframework"),
        .binaryTarget(name: "CommonModels", path: "SDK/CommonModels.xcframework"),
        .binaryTarget(name: "FeatureExercise", path: "SDK/FeatureExercise.xcframework"),
        .binaryTarget(name: "FeatureRecorder", path: "SDK/FeatureRecorder.xcframework"),
        .binaryTarget(name: "FeatureTime", path: "SDK/FeatureTime.xcframework"),
        .binaryTarget(name: "FeatureVideo", path: "SDK/FeatureVideo.xcframework"),
        .binaryTarget(name: "FeatureWorkout", path: "SDK/FeatureWorkout.xcframework")
    ]
)
