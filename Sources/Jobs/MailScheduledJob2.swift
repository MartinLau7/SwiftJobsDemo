import Jobs

final class MailScheduledJob2: ScheduledJob, @unchecked Sendable {
    struct Parameters: JobParameters {
        static let jobName = "mail_scheduled_send2"
    }

    func execute(_: Parameters, context _: Jobs.JobContext) async throws {
        print("Start send mail job2")
        defer {
            print("End send mail job2")
        }
        // 发送邮件
        for idx in 0 ... 100 {
            try await Task.sleep(for: .seconds(0.5))
            print("Send mail with index 2-\(idx)")
        }
    }
}
