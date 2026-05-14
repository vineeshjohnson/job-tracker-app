import 'package:equatable/equatable.dart';

class JobEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteJobRequested extends JobEvent {
  final String jobId;

  DeleteJobRequested({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}

class GetJobsRequested extends JobEvent {}

class AddJobRequested extends JobEvent {
  final String companyName;

  final String jobRole;

  final String location;

  final String salary;

  final String jobType;

  final String status;

  final String notes;
  final DateTime appliedDate;

  final DateTime createdAt;

  final DateTime updatedAt;

  final  String userId;

  AddJobRequested({
    required this.companyName,

    required this.jobRole,

    required this.location,

    required this.salary,

    required this.jobType,

    required this.status,

    required this.notes,
    required this.appliedDate,
    required this.createdAt,
    required this.updatedAt, required this.userId,
  });

  @override
  List<Object?> get props => [
    companyName,

    jobRole,

    location,

    salary,

    jobType,

    status,

    notes,
    updatedAt,
    createdAt,
    updatedAt,
    userId
  ];
}

class UpdateJobStatusRequested extends JobEvent {
  final String jobId;

  final String status;

  UpdateJobStatusRequested({required this.jobId, required this.status});

  @override
  List<Object?> get props => [jobId, status];
}
