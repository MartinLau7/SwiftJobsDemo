import Jobs

/// Describes a job that can be scheduled and repeated
protocol ScheduledJob: Sendable {
    associatedtype ParameterType: JobParameters

    var name: String { get }

    /// The method called when the job is run
    func execute(_ parameters: ParameterType, context: JobContext) async throws
}

extension ScheduledJob {
    public var name: String { "\(Self.self)" }
}
