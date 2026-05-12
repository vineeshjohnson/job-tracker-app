import '../entities/job_entity.dart';

abstract class JobRepository {

  Future<void> addJob(JobEntity job);

  Stream<List<JobEntity>> getJobs();
}