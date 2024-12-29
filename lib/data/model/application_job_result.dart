import 'package:job_finder_app/data/model/application.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';

class ApplicationJobResult {
  final List<Application>? applications;
  final List<Job>? job;
  final List<JobSeeker>? jobSeeker;

  ApplicationJobResult(this.applications, {this.job, this.jobSeeker});
}
