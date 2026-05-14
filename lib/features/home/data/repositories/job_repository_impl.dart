import '../../domain/entities/job_entity.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_datasource.dart';
import '../models/job_model.dart';

class JobRepositoryImpl implements JobRepository {

  final JobRemoteDataSource remoteDataSource;

  JobRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<void> addJob(JobEntity job) async {

    final jobModel = JobModel(

      id: job.id,

      companyName: job.companyName,

      jobRole: job.jobRole,

      location: job.location,

      salary: job.salary,

      jobType: job.jobType,

      status: job.status,

      notes: job.notes,

      appliedDate: job.appliedDate,

      createdAt: job.createdAt,

      updatedAt: job.updatedAt,
      userId: job.userId
    );

    await remoteDataSource.addJob(jobModel);
  }
  @override
Stream<List<JobEntity>> getJobs() {

  return remoteDataSource.getJobs();
}

@override
Future<void> deleteJob(String jobId) async {

  await remoteDataSource.deleteJob(jobId);
}
@override
Future<void> updateJobStatus({

  required String jobId,

  required String status,

}) async {

  await remoteDataSource.updateJobStatus(
    jobId: jobId,
    status: status,
  );
}
}