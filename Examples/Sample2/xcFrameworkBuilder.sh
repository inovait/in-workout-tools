#!/bin/bash
set -e

if [ -n "$1" ]; then
    configuration="$1"
else
    configuration="Debug"
fi

targets=("FeatureWorkout" "CommonModels" "WorkoutFramework")
destinations=("generic/platform=iOS Simulator" "generic/platform=iOS")

tuist generate --no-open

for target in "${targets[@]}"; do
    for destination in "${destinations[@]}"; do
        xcodebuild \
            -workspace InWorkoutTools.xcworkspace \
            -scheme $target \
            -destination "$destination" \
            -configuration "$configuration" \
            -derivedDataPath dd
    done
done

for target in "${targets[@]}"; do
    xcodebuild -create-xcframework \
        -framework "dd/Build/Products/$configuration-iphoneos/$target.framework" \
        -framework "dd/Build/Products/$configuration-iphonesimulator/$target.framework" \
        -output "XCFrameworks/$target.xcframework"
done
