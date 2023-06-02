// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pango",
    products: [
        .library(
            name: "Pango",
            targets: ["Pango"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/AgentFeeble/Cairo", branch: "pango"),
    ],
    targets: [
        .target(
            name: "Pango",
            dependencies: [
                "Cairo",
                "CPango"
            ]
        ),
        .systemLibrary(
            name: "CPango",
            pkgConfig: "pangocairo",
            providers: [
                .brew(["pango", "glib"]),
                .apt(["libpango1.0-dev", "libglib2.0-dev"])
        ]),
        .testTarget(
            name: "PangoTests",
            dependencies: ["Pango"]
        ),
    ]
)
