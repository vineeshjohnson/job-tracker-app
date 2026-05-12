import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_bloc.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_event.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_state.dart';
import 'package:job_tracker/features/home/presentation/pages/add_job_page.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<JobBloc>().add(GetJobsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),

        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
         
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is JobsLoaded) {
            if (state.jobs.isEmpty) {
              return const Center(child: Text("No Jobs Added"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: state.jobs.length,

              itemBuilder: (context, index) {
                final job = state.jobs[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),

                  child: ListTile(
                    title: Text(job.companyName),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(job.jobRole),

                        Text(job.location),

                        const SizedBox(height: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(job.status),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is JobFailure) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const AddJobPage()),
          );
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
