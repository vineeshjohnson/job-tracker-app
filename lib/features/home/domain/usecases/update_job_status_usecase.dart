import '../repositories/job_repository.dart';

class UpdateJobStatusUseCase {

  final JobRepository repository;

  UpdateJobStatusUseCase({
    required this.repository,
  });

  Future<void> call({

    required String jobId,

    required String status,

  }) async {

    await repository.updateJobStatus(
      jobId: jobId,
      status: status,
    );
  }
}