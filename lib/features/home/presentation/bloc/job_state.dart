import 'package:equatable/equatable.dart';
import 'package:job_tracker/features/home/domain/entities/job_entity.dart';

class JobState extends Equatable {

  @override
  List<Object?> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobSuccess extends JobState {}

class JobFailure extends JobState {

  final String message;

  JobFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class JobsLoaded extends JobState {

  final List<JobEntity> jobs;

  JobsLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}