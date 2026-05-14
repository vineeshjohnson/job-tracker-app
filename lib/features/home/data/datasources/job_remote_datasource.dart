import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/firestore_constants.dart';
import '../models/job_model.dart';

class JobRemoteDataSource {
  final FirebaseFirestore firestore;

  JobRemoteDataSource({required this.firestore});

  Future<void> addJob(JobModel job) async {
    print("job id is "+job.userId);
    await firestore
        .collection(FirestoreConstants.jobsCollection)
        .doc(job.id)
        .set(job.toMap());
  }

  Stream<List<JobModel>> getJobs() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return firestore
        .collection(FirestoreConstants.jobsCollection)
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return JobModel.fromMap(doc.data());
          }).toList();
        });
  }

  Future<void> deleteJob(String jobId) async {
    await firestore.collection("jobs").doc(jobId).delete();
  }

  Future<void> updateJobStatus({
    required String jobId,

    required String status,
  }) async {
    await firestore.collection("jobs").doc(jobId).update({"status": status});
  }
}
