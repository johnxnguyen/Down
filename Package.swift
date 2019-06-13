// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Down",
    platforms: [
        .macOS("10.11"),
        .iOS("9.0"),
        .tvOS("9.0"),
        .watchOS("2.0"),
    ],
    products: [
    .library(
        name: "Down",
        targets: ["Down"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "libcmark",
            dependencies: [],
            path: "Source/cmark",
            exclude: ["include"],
            publicHeadersPath: "./"),
        .target(
            name: "Down",
            dependencies: ["libcmark"],
            path: "Source/",
            exclude: ["cmark", "Down.h"]),
        .testTarget(
            name: "DownTests",
            dependencies: ["Down"],
            path: "Tests/",
            exclude: ["Fixtures", "DownViewTests.swift"]),
    ]
)
