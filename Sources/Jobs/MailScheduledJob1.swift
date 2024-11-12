import Jobs

final class MailScheduledJob1: ScheduledJob, @unchecked Sendable {
    struct Parameters: JobParameters {
        static let jobName = "mail_scheduled_send1"

        var to: String
        var subject: String
        var body: String
    }

    func execute(_ parameters: Parameters, context _: Jobs.JobContext) async throws {
        print("Start send mail job1")
        defer {
            print("End send mail job1")
        }
        // send mail to user
        try await Task.sleep(for: .seconds(5))
        print("send mail to \(parameters.to), subject: \(parameters.subject), body: \(parameters.body)")
    }
}
