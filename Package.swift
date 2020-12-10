// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "JustABunchOfGrapes",
    products: [
        .executable(
            name: "JustABunchOfGrapes",
            targets: ["JustABunchOfGrapes"]
        ),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/Mastermakrela/publish.git", .branch("ChangeLocalServer")),
    ],
    targets: [
        .target(
            name: "JustABunchOfGrapes",
            dependencies: ["Publish"]
        ),
    ]
)
