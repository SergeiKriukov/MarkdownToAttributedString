// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarkdownToAttributedString",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "MarkdownToAttributedString",
            targets: ["MarkdownToAttributedString"]),
        .executable(
            name: "MarkdownExample",
            targets: ["MarkdownExample"]),
        .executable(
            name: "TestNewFeatures",
            targets: ["TestNewFeatures"]),
    ],
    targets: [
        .target(
            name: "MarkdownToAttributedString",
            dependencies: [],
            path: "Sources/MarkdownToAttributedString",
            resources: []),
        .executableTarget(
            name: "MarkdownExample",
            dependencies: ["MarkdownToAttributedString"],
            path: "Sources/MarkdownExample"),
        .executableTarget(
            name: "TestNewFeatures",
            dependencies: ["MarkdownToAttributedString"],
            path: "Sources/TestNewFeatures"),
        .testTarget(
            name: "MarkdownToAttributedStringTests",
            dependencies: ["MarkdownToAttributedString"],
            path: "Tests/MarkdownToAttributedStringTests"),
    ],
    swiftLanguageVersions: [.v5]
)
