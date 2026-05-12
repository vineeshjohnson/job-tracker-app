import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/job_bloc.dart';
import '../bloc/job_event.dart';
import '../bloc/job_state.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final companyController = TextEditingController();

  final roleController = TextEditingController();

  final locationController = TextEditingController();

  final salaryController = TextEditingController();

  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Job")),

      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobSuccess) {
            context.read<JobBloc>().add(GetJobsRequested());

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Job Added")));

            Navigator.pop(context);
          }

          if (state is JobFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: companyController,
                    decoration: const InputDecoration(hintText: "Company Name"),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: roleController,
                    decoration: const InputDecoration(hintText: "Job Role"),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(hintText: "Location"),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: salaryController,
                    decoration: const InputDecoration(hintText: "Salary"),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(hintText: "Notes"),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {
                      context.read<JobBloc>().add(
                        AddJobRequested(
                          companyName: companyController.text,

                          jobRole: roleController.text,

                          location: locationController.text,

                          salary: salaryController.text,

                          jobType: "Full Time",

                          status: "Applied",

                          notes: notesController.text,
                        ),
                      );
                    },

                    child: state is JobLoading
                        ? const CircularProgressIndicator()
                        : const Text("Add Job"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
