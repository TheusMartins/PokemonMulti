// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokemonTeam",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PokemonTeam",
            targets: ["PokemonTeam"]),
    ],
    dependencies: [
        .package(path: "../DesignSystem/"),
        .package(path: "../Coordinator/")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PokemonTeam",
            dependencies: [
                "DesignSystem"
            ]
        ),
        .testTarget(
            name: "PokemonTeamTests",
            dependencies: [
                "PokemonTeam",
                "Coordinator"
            ],
            resources: []
        ),
    ]
)
