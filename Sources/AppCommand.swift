import ArgumentParser

import Jobs
import Logging
import NIOCore
import ServiceLifecycle

public protocol AppArguments {
    // var processJobs: Bool { get }
}

@main
struct ApplicationCommand: AsyncParsableCommand, AppArguments, Sendable {
    // @Flag(name: .shortAndLong)
    // var processJobs: Bool = true

    func run() async throws {
        // 載入配置模式

        // 创建并启动服务器
        let bootstrap = AppBootstrap()
        let appService = try await bootstrap.bootstrap()
        try await appService.run()
    }
}
