import 'package:job_finder_app/data/model/application.dart';
import 'package:job_finder_app/data/model/job.dart';

class ApplicationJobResult {
  final List<Application>? applications;
  final List<Job>? job;

  ApplicationJobResult(this.applications, this.job);
}