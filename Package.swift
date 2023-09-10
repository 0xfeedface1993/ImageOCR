// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageOCR",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ImageOCR",
            targets: ["ImageOCR"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/0xfeedface1993/CImageMagick.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ImageOCR",
            dependencies: [
                "CImageMagick",
                    .product(name: "Logging", package: "swift-log"),
            ]
//            cxxSettings: [
//                .define("MAGICKCORE_HDRI_ENABLE", to: "1"),
//                .define("MAGICKCORE_QUANTUM_DEPTH", to: "16"),
//            ],
//            swiftSettings: [
//                .unsafeFlags(["-I/usr/local/Cellar/imagemagick/7.1.1-15_1/include/ImageMagick-7"],
//                             .when(platforms: [.macOS], configuration: .debug)),
//                .unsafeFlags(["-I/usr/local/include/ImageMagick-7"],
//                             .when(platforms: [.linux], configuration: .debug)),
//            ],
//            linkerSettings: [
//                .unsafeFlags([
//                    "-L/usr/local/Cellar/imagemagick/7.1.1-15_1/lib",
//                    "-lMagickWand-7.Q16HDRI",
//                    "-lMagickCore-7.Q16HDRI"
//                ], .when(platforms: [.macOS], configuration: .debug)),
//                .unsafeFlags([
//                    "-L/usr/local/lib",
//                    "-lMagickWand-7.Q16HDRI",
//                    "-lMagickCore-7.Q16HDRI"
//                ], .when(platforms: [.linux], configuration: .debug))
//            ]
        ),
        .testTarget(
            name: "ImageOCRTests",
            dependencies: ["ImageOCR"],
            resources: [.process("Resources")]
        ),
    ]
)
