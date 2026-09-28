#!/bin/bash

# Clean the build
echo "Cleaning the project..."
flutter clean

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build the Android App Bundle (AAB)
echo "Building the Android App Bundle (AAB)..."
flutter build appbundle --release

echo "Build complete! You can find the AAB at: build/app/outputs/bundle/release/app-release.aab"
