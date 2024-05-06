// swift-tools-version:5.8.1
import PackageDescription


let package = Package(
    name: "SomeFramework",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SomeFramework",
            targets: ["SomeFramework"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SomeFramework",
            dependencies: [],
            path: "SomeFramework/Sources"
        )
    ]
)
