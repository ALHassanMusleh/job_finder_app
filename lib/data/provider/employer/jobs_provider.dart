import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job.dart';

class SavedJobsProvider extends ChangeNotifier {
  final List<Job> _savedJobsList = [];

  List<Job> get savedJobsList => _savedJobsList!;
  toggleWatchlist(Job job) {
    if (moviesIsBooked(job)) {
      _savedJobsList.removeWhere((jobL) => job.id == jobL.id);
    } else {
      _savedJobsList.add(job);
    }
    notifyListeners();
  }

  bool moviesIsBooked(Job job) {
    for (int i = 0; i < _savedJobsList.length; i++) {
      if (job.id == _savedJobsList[i].id) {
        return true;
      }
    }
    return false;
  }
}
