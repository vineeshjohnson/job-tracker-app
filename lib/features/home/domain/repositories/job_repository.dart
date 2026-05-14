import '../entities/job_entity.dart';

abstract class JobRepository {

  Future<void> addJob(JobEntity job);

  Stream<List<JobEntity>> getJobs();

  Future<void> deleteJob(String jobId);
  Future<void> updateJobStatus({

  required String jobId,

  required String status,
});
}