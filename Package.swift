// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-text",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Text", targets: ["Text"]),
        .library(name: "Text Standard Library Integration", targets: ["Text Standard Library Integration"]),
        .library(name: "Text Foundation Library Integration", targets: ["Text Foundation Library Integration"]),
        .library(name: "Text Test Support", targets: ["Text Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-difference.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Text",
            dependencies: [
                .product(name: "Difference", package: "swift-difference"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Text"
        ),
        .target(
            name: "Text Standard Library Integration",
            dependencies: [
                .target(name: "Text"),
            ],
            path: "Sources/Text Standard Library Integration"
        ),
        .target(
            name: "Text Foundation Library Integration",
            dependencies: [
                .target(name: "Text"),
                .target(name: "Text Standard Library Integration"),
            ],
            path: "Sources/Text Foundation Library Integration"
        ),
        .target(
            name: "Text Test Support",
            dependencies: [
                .target(name: "Text"),
                .product(name: "Cardinal Standard Library Integration", package: "swift-cardinal"),
                .product(name: "Tagged Standard Library Integration", package: "swift-tagged"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Text Tests",
            dependencies: [
                .target(name: "Text"),
                .target(name: "Text Test Support"),
                .product(name: "Difference", package: "swift-difference"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .target(name: "Text Standard Library Integration"),
                .target(name: "Text Foundation Library Integration"),
            ],
            path: "Tests/Text Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
