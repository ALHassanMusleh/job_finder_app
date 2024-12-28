import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/data/model/application.dart';
import 'package:job_finder_app/data/model/application_job_result.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_application_details_screen/job_seeker_application_details_screen.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class JobSeekerApplicationsTab extends StatelessWidget {
  const JobSeekerApplicationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<ApplicationJobResult>(
            future: JobSeekerServices.getApplicationsForJobSeeker(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // print(snapshot.error.toString());
                // throw Exception(snapshot.error.toString());
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                );
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.applications?.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          JobSeekerApplicationDetailsScreen.routeName,
                          arguments: [
                            snapshot.data!.applications![index],
                            snapshot.data!.job![index]
                          ],
                        );
                      },
                      child: CustomJobAppliedAndDetailsToJobSeeker(
                        application: snapshot.data!.applications![index],
                        job: snapshot.data!.job![index],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomJobAppliedAndDetailsToJobSeeker extends StatelessWidget {
  const CustomJobAppliedAndDetailsToJobSeeker({
    super.key,
    required this.application,
    required this.job,
  });

  final Application application;
  final Job job;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle.containerDecoration,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          CustomJobAppliedCardToJobSeeker(
            job: job,
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        application.status,
                        style: AppStyle.subTitlesTextStyle
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomJobAppliedCardToJobSeeker extends StatelessWidget {
  const CustomJobAppliedCardToJobSeeker({
    super.key,
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      width: MediaQuery.of(context).size.width * .89,
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: AppStyle.containerDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFF9F9FA),
                  width: 1,
                ),
              ),
              child: job.isImageUploaded
                  ? CachedNetworkImage(
                      imageUrl: job.image!,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: MediaQuery.of(context).size.width * .31,
                      height: MediaQuery.of(context).size.height * .22,
                    )
                  : Image.asset('assets/images/businessman.png'),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  job.title,
                  maxLines: 1,
                  style: AppStyle.titlesJobTextStyle.copyWith(),
                ),
                Text(
                  job.employerName,
                  maxLines: 1,
                  style: AppStyle.labelStyle
                      .copyWith(color: const Color(0xff394452)),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.message_2,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
