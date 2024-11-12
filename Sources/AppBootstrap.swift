import Jobs
import Logging
import ServiceLifecycle

final class AppBootstrap {
    func bootstrap() async throws -> ServiceGroup {
        let logger = {
            var logger = Logger(label: "net.tutuapp.healthy.agent")
            logger.logLevel = .debug
            return logger
        }()
        defer {
            logger.info("Agent bootstrap completed.")
        }

        // Register Jobs
        var jobSchedule = JobSchedule()
        let jobQueue = JobQueue(.memory, logger: Logger(label: "net.healthy.AgentJob"))
        let jobsRegister = JobsRegister(queue: jobQueue)

        configureJobs(jobsRegister: jobsRegister, jobSchedule: &jobSchedule)

        let serviceGroupConfiguration = await ServiceGroupConfiguration(
            services: [jobQueue, jobSchedule.scheduler(on: jobQueue)],
            gracefulShutdownSignals: [.sigterm, .sigint],
            logger: logger
        )
        return ServiceGroup(
            configuration: serviceGroupConfiguration
        )
    }

    private func configureJobs(jobsRegister: JobsRegister<MemoryQueue>, jobSchedule: inout JobSchedule) {
        // Register Jobs to container

        // - MailScheduledJob
        let mailScheduledJob1 = MailScheduledJob1()
        let mailParameters1 = MailScheduledJob1.Parameters(to: "abc@mail.com", subject: "Today's Weather Update", body: "This is to inform you of today's weather conditions.")
        jobsRegister.registerScheduledJob(parameters: mailParameters1) {
            mailScheduledJob1
        }
        // every 2 minutes
        let minutes: [Int] = stride(from: 0, through: 59, by: 2).map { $0 }
        jobSchedule.addJob(mailParameters1, schedule: .onMinutes(minutes))

        let mailScheduledJob2 = MailScheduledJob2()
        let mailParameters2 = MailScheduledJob2.Parameters()
        jobsRegister.registerScheduledJob(parameters: mailParameters2) {
            mailScheduledJob2
        }
        // every minute
        jobSchedule.addJob(mailParameters2, schedule: .everyMinute())
    }
}
