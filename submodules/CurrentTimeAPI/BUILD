load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "CurrentTimeAPI",
    module_name = "CurrentTimeAPI",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    copts = [
        "-warnings-as-errors",
    ],
    deps = [
        "//submodules/APIFetcher:APIFetcher",
    ],
    visibility = [
        "//visibility:public",
    ],
)
