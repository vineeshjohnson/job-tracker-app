import '../../domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,

    required super.companyName,

    required super.jobRole,

    required super.location,

    required super.salary,

    required super.jobType,

    required super.status,

    required super.notes,

    required super.appliedDate,

    required super.createdAt,

    required super.updatedAt,
  });

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] ?? '',

      companyName: map['companyName'] ?? '',

      jobRole: map['jobRole'] ?? '',

      location: map['location'] ?? '',

      salary: map['salary'] ?? '',

      jobType: map['jobType'] ?? '',

      status: map['status'] ?? '',

      notes: map['notes'] ?? '',

      appliedDate: DateTime.parse(map['appliedDate']),

      createdAt: DateTime.parse(map['createdAt']),

      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'companyName': companyName,

      'jobRole': jobRole,

      'location': location,

      'salary': salary,

      'jobType': jobType,

      'status': status,

      'notes': notes,

      'appliedDate': appliedDate.toIso8601String(),

      'createdAt': createdAt.toIso8601String(),

      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
