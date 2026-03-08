// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedResources",
    platforms: [.iOS(.v16)],
    products: [

        .library(
            name: "SharedResources",
            targets: ["SharedResources"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MoathOthman/MOLH", exact: "1.4.3"),
        .package(url: "https://github.com/JonasGessner/JGProgressHUD.git", from: "2.2.0"),
        .package(url: "https://github.com/teodorpatras/EasyTipView.git", from: "2.1.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.11.1"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", "8.6.2"..<"9.0.0"),
        .package(url: "https://github.com/EslamAbotaleb/Toast-Swift.git", branch: "master"),
        .package(url: "https://github.com/google/promises.git", from: "2.4.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.9.1"),
        .package(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git", exact: "6.0.0"),
        .package(url: "https://github.com/kukushi/SideMenu.git", from: "2.1.1"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", branch: "master"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.2"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", exact: "5.21.5"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", exact: "1.8.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", exact: "3.5.0"),
        .package(url: "https://github.com/EslamAbotaleb/keychain-swift.git", branch: "master"),
        .package(url: "https://github.com/EslamAbotaleb/Reachability.swift.git", branch: "master")
    ],
    targets: [
        .target(
            name: "SharedResources",
            dependencies: [
                .product(name: "MOLH", package: "MOLH"),
                .product(name: "JGProgressHUD", package: "JGProgressHUD"),
                .product(name: "EasyTipView", package: "EasyTipView"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Toast", package: "Toast-Swift"),
                .product(name: "Promises", package: "Promises"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxAlamofire", package: "RxAlamofire"),
                .product(name: "SideMenu", package: "SideMenu"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "SDWebImageSVGCoder", package: "SDWebImageSVGCoder"),
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "KeychainSwift", package: "keychain-swift"),
                .product(name: "Reachability", package: "Reachability.swift")
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                   .unsafeFlags(["-Xfrontend", "-strict-concurrency=minimal"])
            ]
        )
    ]
)
