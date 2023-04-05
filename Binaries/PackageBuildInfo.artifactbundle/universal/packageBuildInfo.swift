#!/usr/bin/env swift

import Foundation

enum ExecError: Error {
    case invalidArguments
}

let arguments = ProcessInfo().arguments
guard arguments.count > 2 else {
    throw ExecError.invalidArguments
}

let repositoryPath = arguments[1]
let outputDirectory = arguments[2]

let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
process.arguments = ["--git-dir", repositoryPath, "describe", "--tags"]

let outputPipe = Pipe()
process.standardOutput = outputPipe
try process.run()
process.waitUntilExit()

let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
let version = String(decoding: outputData, as: UTF8.self)

let source = """
import Foundation

public struct PackageInfo {
    public static let version = "\(version)"
}
"""

let fileUrl = URL(fileURLWithPath: outputDirectory).appendingPathComponent("PackageInfo.swift")
try source.write(to: fileUrl, atomically: true, encoding: .utf8)
