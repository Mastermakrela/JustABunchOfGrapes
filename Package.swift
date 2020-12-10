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
        .package(name: "MinifyCSSPublishPlugin", url: "https://github.com/labradon/minifycsspublishplugin", from: "0.1.0"),
        .package(name: "SassPublishPlugin", url: "https://github.com/hejki/sasspublishplugin", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "JustABunchOfGrapes",
            dependencies: [
                "Publish",
                "MinifyCSSPublishPlugin",
                "SassPublishPlugin",
            ]
        ),
    ]
)
