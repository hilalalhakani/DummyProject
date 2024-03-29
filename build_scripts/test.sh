#!/bin/bash

PACKAGES_PATH="packages_cache"

if $HAS_PACKAGES_CACHE_HIT; then
    # if we have packages in cache, we skip resolution, via disableAutomaticPackageResolution
  echo "🎉Using cached dependencies"
  set -o pipefail && xcrun xcodebuild test \
    -scheme DummyProject \
    -project DummyProject.xcodeproj \
    -skipPackageUpdates \
    -disableAutomaticPackageResolution \
    -clonedSourcePackagesDirPath "$PACKAGES_PATH" |
    xcbeautify --renderer github-actions
else
  # otherwise we run xcodebuild with full spm packages resolution
  echo "Cache not found, loading dependencies 🤕"
  set -o pipefail && xcrun xcodebuild test \
    -scheme DummyProject \
    -project DummyProject.xcodeproj \
    -disableAutomaticPackageResolution \
    -clonedSourcePackagesDirPath "$PACKAGES_PATH" |
    xcbeautify --renderer github-actions
fi
