// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .staticFramework, // default is .staticFramework
            "SDWebImageSwiftUI": .staticFramework
        ]
    )
#endif

let package = Package(
    name: "InWorkoutTools",
    // platforms: [
    //     .iOS(.v16)
    // ],
    // products: [
    //     // Products define the executables and libraries a package produces, and make them visible to other packages.
    //     .library(
    //         name: "FeatureWorkout",
    //         targets: ["FeatureWorkout"])
    // ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "shared-state-beta"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.2.6")
    ]
)
