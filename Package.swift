// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "JustABunchOfGrapes",
    products: [
        .executable(
            name: "JustABunchOfGrapes",
            targets: ["JustABunchOfGrapes"]
        )
    ],
    dependencies: [
//        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0")
        .package(path: "/Users/mastermakrela/Projects/CommunityWork/Publish")
    ],
    targets: [
        .target(
            name: "JustABunchOfGrapes",
            dependencies: ["Publish"]
        )
    ]
)
