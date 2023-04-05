/////
////  plugin.swift
///   Copyright © 2022 Dmitriy Borovikov. All rights reserved.
//

import PackagePlugin
import Foundation

@main
struct PackageBuildInfoPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        let repositoryPath = target.directory.appending("../../.git")
        return [
            .prebuildCommand(
                displayName: "Get version",
                executable: try context.tool(named: "PackageBuildInfo").path,
                arguments: [
                    "\(repositoryPath)",
                    "\(context.pluginWorkDirectory)"
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}
