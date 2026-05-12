import 'package:equatable/equatable.dart';

class JobEvent extends Equatable {

  @override
  List<Object?> get props => [];
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

  AddJobRequested({

    required this.companyName,

    required this.jobRole,

    required this.location,

    required this.salary,

    required this.jobType,

    required this.status,

    required this.notes,
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
  ];
}