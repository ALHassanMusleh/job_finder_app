import 'package:flutter/material.dart';
import 'package:job_finder_app/data/service/auth/auth_services.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/login_screen/login_screen.dart';
import 'package:job_finder_app/presentation/screens/common/widgets/choose_user_type_widget.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = 'RegisterScreen';


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isJobSeeker = true;
  bool isPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  void updateUserType(bool userType) {
    setState(() {
      isJobSeeker = userType;
    });
  }

  void changePasswordVisability() {
    isPassword = !isPassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  // const Spacer(
                  //   flex: 4,
                  // ),
                  const Text(
                    'Getting Started!',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const Text(
                    'Create new account',
                    style: AppStyle.subTitlesTextStyle,
                  ),
                  const SizedBox(height: 20),
                  ChooseUserTypeWidget(
                      onUserTypeChanged:
                          updateUserType), // Pass the callback here
                  const SizedBox(height: 20),
                  CustomTextField(
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (password) {
                      if (password == null || password.isEmpty == true) {
                        return "empty passwords are not allowed";
                      }
                      if (password.length < 6) {
                        return "passwords can not be less than 6 charcters";
                      }
                      return null;
                    },
                    isSuffix: true,
                    label: 'Password',
                    isPassword: isPassword,
                    suffixPressed: changePasswordVisability,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'REGISTER',
                    onPressed: () {
                      AuthServices.createAccount(context,
                          email: emailController.text,
                          password: passwordController.text,
                          formKey: formKey,
                          isJobSeeker: isJobSeeker);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                  Text(
                    isJobSeeker
                        ? 'You selected: Job Seeker'
                        : 'You selected: Employer',
                    style: AppStyle.subTitlesTextStyle,
                  ),
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
}
