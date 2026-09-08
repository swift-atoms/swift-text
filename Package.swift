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

        .library(name: "Text Foundation Integration", targets: ["Text Foundation Integration"]),
        .library(name: "Text Test Support", targets: ["Text Test Support"]),
    ],
    dependencies: [

        .package(url: "https://github.com/swift-atoms/swift-carrier.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-difference.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-interval.git",
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
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Difference", package: "swift-difference"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Interval", package: "swift-interval"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Sources/Text"
        ),
        
        .target(
            name: "Text Foundation Integration",
            dependencies: [
                .target(name: "Text"),
            ],
            path: "Sources/Text Foundation Integration"
        ),
        .target(
            name: "Text Test Support",
            dependencies: [
                .target(name: "Text"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
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
                .target(name: "Text Foundation Integration"),
            ],
            path: "Tests/Text Tests"
        ),
        .testTarget(
            name: "Consolidated Text Carrier Tests",
            dependencies: [
.target(name: "Text"), .product(name: "Carrier", package: "swift-carrier")],
            path: "Tests/Consolidated swift-text-carrier"
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
