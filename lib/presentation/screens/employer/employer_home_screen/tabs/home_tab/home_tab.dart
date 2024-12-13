import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchContainer(),
            const SizedBox(
              height: 30,
            ),
            buildLatestJob(),
            const SizedBox(
              height: 30,
            ),
            buildRecentPeopleApplied(),
          ],
        ),
      ),
    );
  }

  Column buildRecentPeopleApplied() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent people Applied',
          style: AppStyle.titlesTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => CustomJobAppliedAndDetails(),
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
        ),
      ],
    );
  }

  Column buildLatestJob() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your latest jobs',
          style: AppStyle.titlesTextStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => CustomJobCard(),
          ),
        ),
      ],
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
}

class CustomJobAppliedAndDetails extends StatelessWidget {
  const CustomJobAppliedAndDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle.containerDecoration,
      child: Column(
        children: [
          const CustomJobAppliedCard(),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'See Details',
                    onPressed: () {},
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

class CustomJobCard extends StatelessWidget {
  const CustomJobCard({
    super.key,
  });

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
              child: Image.asset(
                'assets/images/Icon.png',
                height: 60,
                width: 60,
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
                  'UI/UX Designer',
                  maxLines: 1,
                  style: AppStyle.titlesJobTextStyle.copyWith(),
                ),
                Text(
                  'Twitter',
                  maxLines: 1,
                  style: AppStyle.labelStyle.copyWith(color: Color(0xff394452)),
                ),
                Text(
                  'On site - Full time',
                  maxLines: 1,
                  style: AppStyle.labelStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Active',
                      style: TextStyle(color: AppColors.white),
                    ),
                    padding: EdgeInsets.all(6),
                  ),
                  Text(
                    '\$1500',
                    style: AppStyle.labelStyle.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomJobAppliedCard extends StatelessWidget {
  const CustomJobAppliedCard({
    super.key,
  });

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
              child: Image.asset(
                'assets/images/Icon.png',
                height: 60,
                width: 60,
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
                  'Hassan mu',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.titlesJobTextStyle.copyWith(),
                ),
                Text(
                  'Ui / ux designer',
                  maxLines: 1,
                  style: AppStyle.labelStyle.copyWith(color: Color(0xff394452)),
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
