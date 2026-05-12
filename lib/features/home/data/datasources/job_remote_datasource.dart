import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firestore_constants.dart';
import '../models/job_model.dart';

class JobRemoteDataSource {
  final FirebaseFirestore firestore;

  JobRemoteDataSource({required this.firestore});

  Future<void> addJob(JobModel job) async {
    await firestore
        .collection(FirestoreConstants.jobsCollection)
        .doc(job.id)
        .set(job.toMap());
  }


  Stream<List<JobModel>> getJobs() {

  return firestore
      .collection(FirestoreConstants.jobsCollection)
      .snapshots()
      .map((snapshot) {

    return snapshot.docs.map((doc) {

      return JobModel.fromMap(doc.data());

    }).toList();
  });
}
}
