/////
////  plugin.swift
///   Copyright © 2022 Dmitriy Borovikov. All rights reserved.
//

import PackagePlugin
import Foundation

@main
struct PackageBuildInfoPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        [
            .prebuildCommand(
                displayName: "Get version",
                executable: try context.tool(named: "PackageBuildInfo").path,
                arguments: [
                    "\(target.directory.appending("../.."))",
                    "\(context.pluginWorkDirectory)"
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}
