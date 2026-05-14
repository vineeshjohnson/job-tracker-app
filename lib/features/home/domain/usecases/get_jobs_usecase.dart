import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class GetJobsUseCase {
  final JobRepository repository;

  GetJobsUseCase({required this.repository});

  Stream<List<JobEntity>> call() {
    return repository.getJobs();
  }
}
