class JobEntity {
  final String id;

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

  const JobEntity({
    required this.id,

    required this.companyName,

    required this.jobRole,

    required this.location,

    required this.salary,

    required this.jobType,

    required this.status,

    required this.notes,

    required this.appliedDate,

    required this.createdAt,

    required this.updatedAt,
  });
}
