#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BRAND='\033[38;2;255;82;0m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${GREEN}[Version Update]${NC} $1"
}

print_error() {
    echo -e "${RED}[Error]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[Warning]${NC} $1"
}
print_branding() {
    echo -e "${BRAND}${NC} $1"
}

# Function to validate version format
validate_version() {
    if ! [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        print_error "Invalid version format. Use X.Y.Z format (e.g., 1.0.0)"
        exit 1
    fi
}

# Function to validate build number
validate_build_number() {
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        print_error "Invalid build number. Use a positive integer"
        exit 1
    fi
}

 # (Changelog functionality removed as per request)

# Function to update pubspec.yaml
update_pubspec() {
    local version=$1
    local build_number=$2
    local pubspec_file="pubspec.yaml"
    
    if [ ! -f "$pubspec_file" ]; then
        print_error "pubspec.yaml not found"
        exit 1
    fi
    
    # Update version in pubspec.yaml
    sed -i '' "s/version: .*/version: $version+$build_number/" "$pubspec_file"
    print_branding "✅ Updated pubspec.yaml to version $version+$build_number"
}

# Function to update Android version
update_android() {
    local version=$1
    local build_number=$2
    local gradle_file="android/app/build.gradle"
    
    if [ ! -f "$gradle_file" ]; then
        print_warning "Android build.gradle not found"
        return
    fi
    
    # Update fallback version values in Groovy format
    sed -i '' "s/flutterVersionCode = '[0-9]*'/flutterVersionCode = '$build_number'/" "$gradle_file"
    sed -i '' "s/flutterVersionName = '.*'/flutterVersionName = '$version'/" "$gradle_file"
    print_branding "✅  Updated Android version fallback to $version (build $build_number)"
}

# Function to update iOS version
update_ios() {
    local version=$1
    local build_number=$2
    local project_file="ios/Runner.xcodeproj/project.pbxproj"
    local info_plist="ios/Runner/Info.plist"
    
    if [ ! -f "$project_file" ]; then
        print_warning "iOS project.pbxproj not found"
        return
    fi
    
    if [ ! -f "$info_plist" ]; then
        print_warning "iOS Info.plist not found"
        return
    fi
    
    # Update MARKETING_VERSION and CURRENT_PROJECT_VERSION in project.pbxproj
    sed -i '' "s/MARKETING_VERSION = [0-9.]*;/MARKETING_VERSION = $version;/" "$project_file"
    sed -i '' "s/CURRENT_PROJECT_VERSION = [0-9]*;/CURRENT_PROJECT_VERSION = $build_number;/" "$project_file"
    
    # Update CFBundleShortVersionString and CFBundleVersion in Info.plist
    sed -i '' "/<key>CFBundleShortVersionString<\/key>/,/<string>.*<\/string>/s/<string>.*<\/string>/<string>$version<\/string>/" "$info_plist"
    sed -i '' "/<key>CFBundleVersion<\/key>/,/<string>.*<\/string>/s/<string>.*<\/string>/<string>$build_number<\/string>/" "$info_plist"
    
    print_branding "✅  Updated iOS version to $version (build $build_number)"
}

# Main script
if [ "$#" -lt 2 ]; then
    print_error "Usage: $0 <version> <build_number>"
    print_error "Example: $0 1.0.0 1"
    exit 1
fi

VERSION=$1
BUILD_NUMBER=$2

# Validate inputs
validate_version "$VERSION"
validate_build_number "$BUILD_NUMBER"

# Update versions
print_branding "⌛ Starting version update process..."
update_pubspec "$VERSION" "$BUILD_NUMBER"
update_android "$VERSION" "$BUILD_NUMBER"
update_ios "$VERSION" "$BUILD_NUMBER"

print_branding "🎉 Version update completed successfully!"

# Build Android AAB after version update
print_branding "🚀 Starting Android AAB build..."
flutter build appbundle --release