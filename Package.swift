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
            name: "CommonModels",
            targets: ["CommonModels"]),
        .library(
            name: "WorkoutFeature",
            targets: ["WorkoutFeature"])        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(name: "CommonModels", path: "SDK/CommonModels.xcframework"),
        .binaryTarget(name: "WorkoutFeature", path: "SDK/WorkoutFeature.xcframework")
    ]
)
