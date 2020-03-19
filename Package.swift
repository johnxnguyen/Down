// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Down",
    platforms: [
        .macOS("10.11"),
        .iOS("9.0"),
        .tvOS("9.0")
    ],
    products: [
        .library(
            name: "Down",
            targets: ["Down"]
        )
    ],
    targets: [
        .target(
            name: "libcmark",
            dependencies: [],
            path: "Source/cmark",
            exclude: ["include"],
            publicHeadersPath: "./"
        ),
        .target(
            name: "Down",
            dependencies: ["libcmark"],
            path: "Source/",
            exclude: ["cmark", "Down.h"]
        ),
        .testTarget(
            name: "DownTests",
            dependencies: ["Down"],
            path: "Tests/",
            exclude: [
                "AST/VisitorTests.swift",
                "DownViewTests.swift",
                "Fixtures",
                "Styler/BlockQuoteStyleTests.swift",
                "Styler/CodeBlockStyleTests.swift",
                "Styler/DownDebugLayoutManagerTests.swift",
                "Styler/HeadingStyleTests.swift",
                "Styler/LinkStyleTests.swift",
                "Styler/InlineStyleTests.swift",
                "Styler/ListItemStyleTests.swift",
                "Styler/StylerTestSuite.swift",
                "Styler/ThematicBreakSyleTests.swift"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
