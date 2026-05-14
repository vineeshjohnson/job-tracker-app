import '../repositories/job_repository.dart';

class DeleteJobUseCase {

  final JobRepository repository;

  DeleteJobUseCase({
    required this.repository,
  });

  Future<void> call(String jobId) async {

    await repository.deleteJob(jobId);
  }
}