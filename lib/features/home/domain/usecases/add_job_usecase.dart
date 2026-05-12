import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class AddJobUseCase {
  final JobRepository repository;

  AddJobUseCase({required this.repository});

  Future<void> call(JobEntity job) async {
    await repository.addJob(job);
  }
}
