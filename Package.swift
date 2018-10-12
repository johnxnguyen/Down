// swift-tools-version:4.0
import PackageDescription

let package = Package(
  name: "Down",
  products: [
    .library(
      name: "Down",
      targets: ["Down"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "cmark",
      dependencies: []),
    .target(
      name: "Down",
      dependencies: ["cmark"]),
  ]
)
