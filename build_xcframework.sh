#!/bin/bash

set -e

SCHEME="SharedResources"
WORKSPACE=".swiftpm/xcode/package.xcworkspace"
BUILD_DIR=".build/xcframework-build"
OUTPUT_DIR="output"

echo "🔨 Building XCFramework for $SCHEME..."

# Clean previous build artifacts
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/archives"
mkdir -p "$OUTPUT_DIR"

# Remove existing XCFramework output
rm -rf "$OUTPUT_DIR/$SCHEME.xcframework"

echo "📦 Archiving for iOS Device (arm64)..."
xcodebuild archive \
  -workspace "$WORKSPACE" \
  -scheme "$SCHEME" \
  -destination "generic/platform=iOS" \
  -archivePath "$BUILD_DIR/archives/ios.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  OTHER_SWIFT_FLAGS="$(inherited) -no-verify-emitted-module-interface" \
  | xcpretty 2>/dev/null || true

echo "📦 Archiving for iOS Simulator (arm64 + x86_64)..."
xcodebuild archive \
  -workspace "$WORKSPACE" \
  -scheme "$SCHEME" \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "$BUILD_DIR/archives/ios-simulator.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  OTHER_SWIFT_FLAGS="$(inherited) -no-verify-emitted-module-interface" \
  | xcpretty 2>/dev/null || true

# Locate frameworks
IOS_FRAMEWORK="$BUILD_DIR/archives/ios.xcarchive/Products/Library/Frameworks/$SCHEME.framework"
SIM_FRAMEWORK="$BUILD_DIR/archives/ios-simulator.xcarchive/Products/Library/Frameworks/$SCHEME.framework"

if [ ! -d "$IOS_FRAMEWORK" ]; then
  echo "❌ iOS framework not found at: $IOS_FRAMEWORK"
  echo "   Listing archive contents:"
  find "$BUILD_DIR/archives/ios.xcarchive" -name "*.framework" 2>/dev/null
  exit 1
fi

if [ ! -d "$SIM_FRAMEWORK" ]; then
  echo "❌ Simulator framework not found at: $SIM_FRAMEWORK"
  echo "   Listing archive contents:"
  find "$BUILD_DIR/archives/ios-simulator.xcarchive" -name "*.framework" 2>/dev/null
  exit 1
fi

echo "🗜️  Creating XCFramework..."
xcodebuild -create-xcframework \
  -framework "$IOS_FRAMEWORK" \
  -framework "$SIM_FRAMEWORK" \
  -output "$OUTPUT_DIR/$SCHEME.xcframework"

echo ""
echo "✅ XCFramework created at: $OUTPUT_DIR/$SCHEME.xcframework"
echo ""
echo "Supported platforms:"
ls "$OUTPUT_DIR/$SCHEME.xcframework"
