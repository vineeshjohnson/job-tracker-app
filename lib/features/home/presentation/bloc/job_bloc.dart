import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/home/domain/usecases/delete_job_usecase.dart';
import 'package:job_tracker/features/home/domain/usecases/get_jobs_usecase.dart';
import 'package:job_tracker/features/home/domain/usecases/update_job_status_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/job_entity.dart';
import '../../domain/usecases/add_job_usecase.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final AddJobUseCase addJobUseCase;
  final GetJobsUseCase getJobsUseCase;
  final DeleteJobUseCase deleteJobUseCase;
  final UpdateJobStatusUseCase updateJobStatusUseCase;
  JobBloc({
    required this.addJobUseCase,
    required this.getJobsUseCase,
    required this.deleteJobUseCase,
    required this.updateJobStatusUseCase,
  }) : super(JobInitial()) {
    on<GetJobsRequested>((event, emit) async {
      emit(JobLoading());

      await emit.forEach(
        getJobsUseCase(),

        onData: (jobs) {
          return JobsLoaded(jobs);
        },

        onError: (error, stackTrace) {
          return JobFailure(error.toString());
        },
      );
    });

    on<DeleteJobRequested>((event, emit) async {
      try {
        await deleteJobUseCase(event.jobId);
      } catch (e) {
        emit(JobFailure("Failed to delete job"));
      }
    });

    on<AddJobRequested>((event, emit) async {
      emit(JobLoading());

      try {
        final now = DateTime.now();

        final job = JobEntity(
          id: const Uuid().v4(),

          companyName: event.companyName,

          jobRole: event.jobRole,

          location: event.location,

          salary: event.salary,

          jobType: event.jobType,

          status: event.status,

          notes: event.notes,

          appliedDate: now,

          createdAt: now,

          updatedAt: now,
          userId: event.userId,
        );
        print(job.userId);
        await addJobUseCase(job);

        emit(JobSuccess());
      } catch (e) {
        emit(JobFailure(e.toString()));
      }
    });
    on<UpdateJobStatusRequested>((event, emit) async {
      try {
        await updateJobStatusUseCase(jobId: event.jobId, status: event.status);
      } catch (e) {
        emit(JobFailure("Failed to update status"));
      }
    });
  }
}
