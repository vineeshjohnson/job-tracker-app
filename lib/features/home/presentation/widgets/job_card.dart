import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_bloc.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_event.dart';

import '../../domain/entities/job_entity.dart';

class JobCard extends StatelessWidget {
  final JobEntity job;

  const JobCard({super.key, required this.job});

  Color getStatusColor() {
    switch (job.status.toLowerCase()) {
      case "applied":
        return Colors.blue;

      case "interview":
        return Colors.orange;

      case "rejected":
        return Colors.red;

      case "offer":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,

          builder: (bottomSheetContext) {
            final statuses = ["Applied", "Interview", "Offer", "Rejected"];

            return Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: statuses.map((status) {
                  return ListTile(
                    title: Text(status),

                    onTap: () {
                      context.read<JobBloc>().add(
                        UpdateJobStatusRequested(jobId: job.id, status: status),
                      );

                      Navigator.pop(bottomSheetContext);
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },

      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),

        tween: Tween<double>(begin: 0, end: 1),

        builder: (context, value, child) {
          return Opacity(
            opacity: value,

            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),

              child: child,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),

                blurRadius: 10,

                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,

                    child: Text(job.companyName[0].toUpperCase()),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          job.companyName,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          job.jobRole,

                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),

                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "edit") {
                        print("Edit");
                      }

                      if (value == "delete") {
                        showDialog(
                          context: context,

                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text("Delete Job"),

                              content: const Text(
                                "Are you sure you want to delete this job?",
                              ),

                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },

                                  child: const Text("Cancel"),
                                ),

                                TextButton(
                                  onPressed: () {
                                    context.read<JobBloc>().add(
                                      DeleteJobRequested(jobId: job.id),
                                    );

                                    Navigator.pop(dialogContext);
                                  },

                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    itemBuilder: (context) => [
                      const PopupMenuItem(value: "edit", child: Text("Edit")),

                      const PopupMenuItem(
                        value: "delete",
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),

                  const SizedBox(width: 6),

                  Text(job.location),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: getStatusColor().withOpacity(0.12),

                  borderRadius: BorderRadius.circular(30),
                ),

                child: Text(
                  job.status,

                  style: TextStyle(
                    color: getStatusColor(),

                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
