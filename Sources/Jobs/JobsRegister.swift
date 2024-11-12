import Jobs

final class JobsRegister<Queue> where Queue: JobQueueDriver {
    private var jobQueue: JobQueue<Queue>

    init(queue: JobQueue<Queue>) {
        jobQueue = queue
    }

    func registerScheduledJob<J: ScheduledJob, P: JobParameters>(
        parameters: P,
        jobCreator: () -> J
    ) where J.ParameterType == P { // 添加关联类型约束
        let job = jobCreator()
        let scheduledJob = JobDefinition { (parameters: P, context) in
            try await job.execute(parameters, context: context)
        }

        jobQueue.registerJob(scheduledJob)
    }
}
