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
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/inovait/in-workout-tools.git", from: "1.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.1"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.2.6")
    ]
)
