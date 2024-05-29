import ProjectDescription

let VERSION = "0.1.0"

extension SettingsDictionary {
    func setProjectSettings() -> SettingsDictionary {
        
        return appleGenericVersioningSystem().merging([
            "CURRENT_PROJECT_VERSION": SettingValue(stringLiteral: VERSION),
            "MARKETING_VERSION": SettingValue(stringLiteral: "1")
        ]).merging([
            "CODE_SIGN_STYLE": SettingValue(stringLiteral: "Manual"),
            "CODE_SIGN_IDENTITY": SettingValue(stringLiteral: "Apple Distribution"),
            "PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "b7f3b086-fb06-4cbf-a06f-87c19fcacf55"),
            "DEVELOPMENT_TEAM": SettingValue(stringLiteral: "G33XFLC26J"),
        ])
    }
    
    func setFrameworkSettings() -> SettingsDictionary {
        return appleGenericVersioningSystem().merging([
            "CURRENT_PROJECT_VERSION": SettingValue(stringLiteral: VERSION),
            "MARKETING_VERSION": SettingValue(stringLiteral: "1"),
            "BUILD_LIBRARY_FOR_DISTRIBUTION": SettingValue(stringLiteral: "YES")
        ]).merging([
            "EXPANDED_CODE_SIGN_IDENTITY": SettingValue(stringLiteral: ""),
            "CODE_SIGNING_REQUIRED": SettingValue(stringLiteral: "NO"),
            "CODE_SIGNING_ALLOWED": SettingValue(stringLiteral: "NO"),
        ])
    }
}

/*
IMPORTANT: Do not include ComposableArchitecture and SDWebImageSwiftUI as external dependecies,
           because they need to be static frameworks.
           Instead, include CommonTca, it already includes those two.
*/

//.merging(manualCodeSigning(identity: "iPhone Distribution:XXXXXX", provisioningProfileSpecifier: "b7f3b086-fb06-4cbf-a06f-87c19fcacf55"))
//.merging(manualCodeSigning(identity: "iOS Developer", provisioningProfileSpecifier: "InWorkoutDemoAdHoc"))
let project = Project(
    name: "Sample",
    options: ProjectDescription.Project.Options.options(
        automaticSchemesOptions: ProjectDescription.Project.Options.AutomaticSchemesOptions.enabled(targetSchemesGrouping: .notGrouped)
    ),
    targets: [
        .target(
            name: "Sample",
            destinations: .iOS,
            product: .app,
            bundleId: "com.inova.inworkoutdemosample",
            
            deploymentTargets: DeploymentTargets.iOS("17.2"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sample/Sources/**"],
            resources: ["Sample/Resources/**"],
            dependencies: [
                .target(name: "CommonTca", condition: .none),
                .external(name: "CommonModels"),
                .external(name: "WorkoutFramework"),
            ],
            settings: Settings.settings(base: SettingsDictionary().setProjectSettings(), defaultSettings: .recommended)
        ),
        .target(
            name: "SampleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.inova.inworkoutdemo",
            deploymentTargets: DeploymentTargets.iOS("17.2"),
            infoPlist: .default,
            sources: ["Sample/Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "Sample")
            ]
        ),
        .target(
            name: "CommonTca",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "com.inova.CommonTca",
            deploymentTargets: DeploymentTargets.iOS("16.0"),
            infoPlist: .default,
            sources: ["CommonTca/**"],
            resources: [],
            dependencies: [
                .external(name: "ComposableArchitecture", condition: .none),
                .external(name: "SDWebImageSwiftUI", condition: .none)
            ],
            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
        ),
//        .target(
//            name: "FeatureWorkout",
//            destinations: .iOS,
//            product: .staticFramework,
//            bundleId: "com.inova.FeatureWorkout",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["FeatureWorkout/**"],
//            resources: [],
//            dependencies: [
//                .target(name: "FeatureVideo", condition: .none),
//                .target(name: "FeatureExercise", condition: .none)
//            ],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        ),
//        .target(
//            name: "CommonModels",
//            destinations: .iOS,
//            product: .staticFramework,
//            bundleId: "com.inova.CommonModels",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["CommonModels/**"],
//            resources: [],
//            dependencies: [],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        ),
//        .target(
//            name: "FeatureTime",
//            destinations: .iOS,
//            product: .staticFramework,
//            bundleId: "com.inova.FeatureTime",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["FeatureTime/**"],
//            resources: [],
//            dependencies: [
//                .target(name: "CommonTca", condition: .none)
//            ],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        ),
//        .target(
//            name: "FeatureRecorder",
//            destinations: .iOS,
//            product: .staticFramework,
//            bundleId: "com.inova.FeatureRecorder",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["FeatureRecorder/**"],
//            resources: [],
//            dependencies: [
//                .target(name: "CommonTca", condition: .none)
//            ],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        )
//        .target(
//            name: "FeatureVideo",
//            destinations: .iOS,
//            product: .staticFramework,
//            bundleId: "com.inova.FeatureVideo",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["FeatureVideo/**"],
//            resources: [],
//            dependencies: [
//                .target(name: "CommonTca", condition: .none),
//                .target(name: "CommonModels", condition: .none)
//            ],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        ),
//        .target(
//            name: "FeatureExercise",
//            destinations: .iOS,
//            product: .staticFramework,
//            bundleId: "com.inova.FeatureExercise",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["FeatureExercise/**"],
//            resources: [],
//            dependencies: [
//                .target(name: "CommonTca", condition: .none),
//                .target(name: "CommonModels", condition: .none),
//                .target(name: "FeatureRecorder", condition: .none),
//                .target(name: "FeatureTime", condition: .none)
//            ],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        ),
//        .target(
//            name: "WorkoutFramework",
//            destinations: .iOS,
//            product: .framework,
//            bundleId: "com.inova.WorkoutFramework",
//            deploymentTargets: DeploymentTargets.iOS("16.0"),
//            infoPlist: .default,
//            sources: ["WorkoutFramework/**"],
//            resources: [],
//            dependencies: [
//                .target(name: "FeatureWorkout", condition: .none)
//            ],
//            settings: Settings.settings(base: SettingsDictionary().setFrameworkSettings(), defaultSettings: .recommended)
//        )
    ]
)
