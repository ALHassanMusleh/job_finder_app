import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/provider/employer/jobs_provider.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/employer_list_screen/employer_list_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_details_screen/job_details_screen.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class JobSeekerHomeTab extends StatelessWidget {
  JobSeekerHomeTab({super.key});
  late SavedJobsProvider savedJobsProvider;

  @override
  Widget build(BuildContext context) {
    savedJobsProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${JobSeeker.currentJobSeeker?.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppStyle.titlesTextStyle.copyWith(color: AppColors.primary),
            ),
            const SizedBox(
              height: 30,
            ),
            buildSearchContainer(),
            const SizedBox(
              height: 30,
            ),
            buildLatestJob(),
            const SizedBox(
              height: 30,
            ),
            buildLatestTopEmployer(context),
          ],
        ),
      ),
    );
  }

  Container buildSearchContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppStyle.containerDecoration,
      child: const Row(
        children: [
          Icon(
            Iconsax.search_normal,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            'Search',
            style: AppStyle.labelStyle,
          ),
        ],
      ),
    );
  }

  Column buildLatestJob() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'latest jobs',
          style: AppStyle.titlesTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<Job>>(
          future: JobSeekerServices.getRecentJobs(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(fontSize: 40),
                ),
              );
            } else if (snapshot.hasData) {
              return SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   JobApplicationsScreen.routeName,
                      // );
                    },
                    child: CustomJobCardForJobSeeker(
                      job: snapshot.data![index],
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
    );
  }

  buildLatestTopEmployer(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Top Employer',
              style: AppStyle.titlesTextStyle,
            ),
            TextButton(
              child: Text(
                'View all',
                style: AppStyle.subTitlesTextStyle
                    .copyWith(color: AppColors.primary),
              ),
              onPressed: () {
                Navigator.pushNamed(context, EmployerListScreen.routeName);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        FutureBuilder<List<Employer>>(
          future: JobSeekerServices.getTopEmployers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // throw Exception(snapshot.error.toString());
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(fontSize: 40),
                ),
              );
            } else if (snapshot.hasData) {
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   JobApplicationsScreen.routeName,
                      // );
                    },
                    child: CustomEmployerCard(
                      employer: snapshot.data![index],
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
    );
  }
}

class CustomJobCardForJobSeeker extends StatefulWidget {
  CustomJobCardForJobSeeker({
    super.key,
    required this.job,
    this.isShow = true,
  });

  final Job job;
  final bool isShow;

  @override
  State<CustomJobCardForJobSeeker> createState() =>
      _CustomJobCardForJobSeekerState();
}

class _CustomJobCardForJobSeekerState extends State<CustomJobCardForJobSeeker> {
  late SavedJobsProvider savedJobsProvider;

  @override
  Widget build(BuildContext context) {
    savedJobsProvider = Provider.of(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          JobDetailsScreen.routeName,
          arguments: widget.job,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        width: MediaQuery.of(context).size.width * .89,
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: AppStyle.containerDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFF9F9FA),
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: const Color(0xffF7F7FC),
                  radius: 70,
                  child: widget.job.isImageUploaded
                      ? CachedNetworkImage(
                          imageUrl: widget.job.image!,
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
                    widget.job.title,
                    maxLines: 1,
                    style: AppStyle.titlesJobTextStyle.copyWith(),
                  ),
                  Text(
                    widget.job.employerName,
                    maxLines: 1,
                    style: AppStyle.labelStyle
                        .copyWith(color: const Color(0xff394452)),
                  ),
                  widget.isShow
                      ? Text(
                          '${widget.job.location} - ${widget.job.type}',
                          maxLines: 1,
                          style: AppStyle.labelStyle,
                        )
                      : Container(),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            widget.isShow
                ? Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              savedJobsProvider.toggleWatchlist(widget.job);
                            },
                            child: savedJobsProvider.moviesIsBooked(widget.job)
                                ? const Icon(
                                    Icons.bookmark,
                                    color: AppColors.primary,
                                  )
                                : const Icon(
                                    Icons.bookmark_outline,
                                    color: AppColors.primary,
                                  ),
                          ),
                          Text(
                            '\$${widget.job.salary}',
                            style: AppStyle.labelStyle.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class CustomEmployerCard extends StatelessWidget {
  const CustomEmployerCard({
    super.key,
    required this.employer,
  });

  final Employer employer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      width: MediaQuery.of(context).size.width * .89,
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: AppStyle.containerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFF9F9FA),
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xffF7F7FC),
                radius: 70,
                child: employer.isImageUploaded
                    ? CachedNetworkImage(
                        imageUrl: employer.image!,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        width: MediaQuery.of(context).size.width * .31,
                        height: MediaQuery.of(context).size.height * .22,
                      )
                    : Image.asset('assets/images/Icon.png'),
              ),
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
                  employer.name,
                  maxLines: 1,
                  style: AppStyle.titlesJobTextStyle.copyWith(),
                ),
                Text(
                  employer.address,
                  maxLines: 1,
                  style: AppStyle.labelStyle
                      .copyWith(color: const Color(0xff394452)),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
