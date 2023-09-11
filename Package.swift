// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let cxxSettings: [CXXSetting] = [
    .define("MAGICKCORE_HDRI_ENABLE", to: "1"),
    .define("MAGICKCORE_QUANTUM_DEPTH", to: "16"),
    .unsafeFlags(["-fno-openmp"], .when(platforms: [.macOS]))
]

let swiftSettings: [SwiftSetting] = [
//    .unsafeFlags(["-enable-testing"]),
    .unsafeFlags(["-I/usr/local/Cellar/imagemagick/7.1.1-15_1/include/ImageMagick-7"],
                 .when(platforms: [.macOS])),
    .unsafeFlags(["-I/usr/local/include/ImageMagick-7"],
                 .when(platforms: [.linux])),
]

let linkerSettings: [LinkerSetting] = [
    .unsafeFlags([
        "-L/usr/local/Cellar/imagemagick/7.1.1-15_1/lib",
        "-lMagickWand-7.Q16HDRI",
        "-lMagickCore-7.Q16HDRI"
    ], .when(platforms: [.macOS])),
    .unsafeFlags([
        "-L/usr/local/lib",
        "-lMagickWand-7.Q16HDRI",
        "-lMagickCore-7.Q16HDRI"
    ], .when(platforms: [.linux]))
]

let package = Package(
    name: "ImageOCR",
    platforms: [.macOS(.v10_15)],
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
        .package(url: "https://github.com/0xfeedface1993/SwiftyTesseract.git", branch: "develop")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
//        .systemLibrary(name: "CTesseract", pkgConfig: "tesseract", providers: [.brewItem(["libtesseract-dev", "libleptonica-dev"]), .aptItem(["tesseract"])]),
        .target(
            name: "ImageOCR",
            dependencies: [
                "CImageMagick",
//                "CTesseract",
                    .product(name: "Logging", package: "swift-log"),
                    .product(name: "SwiftyTesseract", package: "SwiftyTesseract")
            ],
            resources: [.copy("Resources/tessdata")],
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings,
            linkerSettings: linkerSettings
        ),
        .testTarget(
            name: "ImageOCRTests",
            dependencies: ["ImageOCR"],
            resources: [.process("Resources")],
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings,
            linkerSettings: linkerSettings
        ),
    ]
)
