import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';

class AddJobRequirementScreen extends StatefulWidget {
  const AddJobRequirementScreen({super.key});

  static const String routeName = 'AddJobRequirementScreen';

  @override
  State<AddJobRequirementScreen> createState() =>
      _AddJobRequirementScreenState();
}

class _AddJobRequirementScreenState extends State<AddJobRequirementScreen> {
  TextEditingController requirementsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ui / Ux design',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      CustomTextField(
                        label: 'Write a Requirement',
                        controller: requirementsController,
                        type: TextInputType.text,
                        validate: (text) {
                          if (text == null || text.isEmpty == true) {
                            return "name can not be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: 'Add',
                              isWhiteBg: true,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Requirement',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) =>
                          CustomReguirementWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child:
                        CustomButton(title: 'Add new job', onPressed: () {})),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomReguirementWidget extends StatelessWidget {
  const CustomReguirementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: AppColors.primary,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(
            'sdhsdhhrehsdhpsdohmsdohmsdiohsdoihnsdhoino',
            maxLines: 3,
            style: AppStyle.labelStyle
                .copyWith(fontSize: 14, color: AppColors.black),
          )),
        ],
      ),
    );
  }
}
