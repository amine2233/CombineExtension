// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "combine-extension",
    platforms: [.macOS(.v10_15), .iOS(.v13), .watchOS(.v6), .tvOS(.v13)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "CombineExtension", targets: ["CombineExtension"]),
        .library(name: "CombineExtensionUI", targets: ["CombineExtensionUI"]),
        .library(name: "CombineExtensionUserDefaults", targets: ["CombineExtensionUserDefaults"]),
		.library(name: "CombineBinding", targets: ["CombineBinding"]),
		.library(name: "CombineExtensionXCTest", targets: ["CombineExtensionXCTest"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CombineExtension",
            dependencies: []),
        .target(
            name: "CombineExtensionUI",
            dependencies: ["CombineExtension"]),
        .target(
            name: "CombineExtensionUserDefaults",
            dependencies: ["CombineExtension"]),
		.target(name: "CombineBinding",
				dependencies: []),
		.target(name: "CombineExtensionXCTest",
				dependencies: []),
        .testTarget(
            name: "CombineExtensionTests",
            dependencies: ["CombineExtension"]),
        .testTarget(
            name: "CombineExtensionUITests",
            dependencies: ["CombineExtensionUI", "CombineExtension"]),
        .testTarget(
            name: "CombineExtensionUserDefaultsTests",
            dependencies: ["CombineExtensionUserDefaults", "CombineExtension"]),
		.testTarget(name: "CombineBindingTests",
				dependencies: ["CombineBinding"]),
    ]
)
