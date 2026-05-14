import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/app/theme/theme_cubit.dart';
import 'package:job_tracker/core/constants/app_sizes.dart';
import 'package:job_tracker/features/auth/presentation/bloc/auth_state.dart';
import 'package:job_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_bloc.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_event.dart';
import 'package:job_tracker/features/home/presentation/bloc/job_state.dart';
import 'package:job_tracker/features/home/presentation/pages/add_job_page.dart';
import 'package:job_tracker/features/home/presentation/widgets/job_card.dart';
import '../widgets/dashboard_stat_card.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../widgets/job_status_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  String selectedSort = "Recent";
  @override
  void initState() {
    super.initState();

    context.read<JobBloc>().add(GetJobsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),

          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },

              icon: const Icon(Icons.logout),
            ),
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },

              icon: const Icon(Icons.dark_mode),
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.work_outline,

                          size: 90,

                          color: Colors.grey.shade400,
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          "No Applications Yet",

                          style: TextStyle(
                            fontSize: 24,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Start tracking your job applications and manage your career journey.",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.grey.shade600,

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 32),

                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) => const AddJobPage(),
                              ),
                            );
                          },

                          icon: const Icon(Icons.add),

                          label: const Text("Add Job"),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final filteredJobs = state.jobs.where((job) {
                return job.companyName.toLowerCase().contains(searchQuery) ||
                    job.jobRole.toLowerCase().contains(searchQuery);
              }).toList();
              final appliedCount = state.jobs
                  .where((job) => job.status == "Applied")
                  .length;
              // 👇 PUT SORTING HERE

              if (selectedSort == "Recent") {
                filteredJobs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
              }

              if (selectedSort == "Oldest") {
                filteredJobs.sort((a, b) => a.createdAt.compareTo(b.createdAt));
              }

              if (selectedSort == "Status") {
                filteredJobs.sort((a, b) => a.status.compareTo(b.status));
              }

              final totalJobs = state.jobs.length;

              final interviewCount = state.jobs
                  .where((job) => job.status == "Interview")
                  .length;

              final offerCount = state.jobs
                  .where((job) => job.status == "Offer")
                  .length;

              final rejectedCount = state.jobs
                  .where((job) => job.status == "Rejected")
                  .length;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: selectedSort,

                      decoration: InputDecoration(
                        filled: true,

                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide.none,
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: "Recent",
                          child: Text("Recent"),
                        ),

                        DropdownMenuItem(
                          value: "Oldest",
                          child: Text("Oldest"),
                        ),

                        DropdownMenuItem(
                          value: "Status",
                          child: Text("Status"),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          selectedSort = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },

                      decoration: InputDecoration(
                        hintText: "Search jobs...",

                        prefixIcon: const Icon(Icons.search),

                        filled: true,

                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        DashboardStatCard(
                          title: "Total",

                          value: totalJobs.toString(),

                          icon: Icons.work_outline,

                          color: Colors.blue,
                        ),

                        const SizedBox(width: 12),

                        DashboardStatCard(
                          title: "Interviews",

                          value: interviewCount.toString(),

                          icon: Icons.record_voice_over,

                          color: Colors.orange,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        DashboardStatCard(
                          title: "Offers",

                          value: offerCount.toString(),

                          icon: Icons.check_circle_outline,

                          color: Colors.green,
                        ),

                        const SizedBox(width: 12),

                        DashboardStatCard(
                          title: "Rejected",

                          value: rejectedCount.toString(),

                          icon: Icons.cancel_outlined,

                          color: Colors.red,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    JobStatusChart(
                      appliedCount: appliedCount,

                      interviewCount: interviewCount,

                      offerCount: offerCount,

                      rejectedCount: rejectedCount,
                    ),

                    const SizedBox(height: 24),

                    ListView.builder(
                      shrinkWrap: true,

                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: filteredJobs.length,

                      itemBuilder: (context, index) {
                        final job = filteredJobs[index];

                        return JobCard(job: job);
                      },
                    ),
                  ],
                ),
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
      ),
    );
  }
}
