import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/home/domain/usecases/get_jobs_usecase.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/job_entity.dart';
import '../../domain/usecases/add_job_usecase.dart';
import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {

  final AddJobUseCase addJobUseCase;
  final GetJobsUseCase getJobsUseCase;

  JobBloc({
  required this.addJobUseCase,
  required this.getJobsUseCase,
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
        );

        await addJobUseCase(job);

        emit(JobSuccess());

      } catch (e) {

        emit(
          JobFailure(
            e.toString(),
          ),
        );
      }
    });
  }
}