import 'package:flutter/material.dart';
import 'package:job_finder_app/data/service/auth/auth_services.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';

class EmployerProfileScreen extends StatefulWidget {
  const EmployerProfileScreen({super.key});

  @override
  State<EmployerProfileScreen> createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  DateTime selectedDate = DateTime.now();
  bool isJobSeeker = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employer Profile'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/images/Icon.png'),
                          backgroundColor: const Color(0xffF7F7FC),
                          radius: 70,
                        ),
                        Positioned(
                          bottom: 0,
                          right: -10,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xffF7F7FC),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    type: TextInputType.name,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "name can not be empty";
                      }
                      return null;
                    },
                    label: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    // initialValue: 'hassan@gamil.com',
                    type: TextInputType.emailAddress,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "emails can not be empty";
                      }
                      if (!text.isValidEmail) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    label: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    type: TextInputType.name,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "name can not be empty";
                      }
                      return null;
                    },
                    label: 'Address',
                    controller: addressController,
                  ),
                  const SizedBox(height: 30),

                  Text(
                    'Select company establishment date',
                    style: AppStyle.bottomSheetTitle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      showMyDatePicker();
                    },
                    child: Text(
                      selectedDate.toFormattedDate,
                      style: AppStyle.normalGreyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    title: 'CONFIRM',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                  // Text(
                  //   isJobSeeker
                  //       ? 'You selected: Job Seeker'
                  //       : 'You selected: Employer',
                  //   style: AppStyle.subTitlesTextStyle,
                  // ),
                  // const Spacer(
                  //   flex: 6,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          lastDate: DateTime.now(),
          firstDate: DateTime.now().subtract(
            const Duration(days: 7300),
          ),
        ) ??
        selectedDate;
    setState(() {});
  }
}
