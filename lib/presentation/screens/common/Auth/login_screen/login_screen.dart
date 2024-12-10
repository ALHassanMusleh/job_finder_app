import 'package:flutter/material.dart';
import 'package:job_finder_app/data/service/auth/auth_services.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/register_screen/register_screen.dart';
import 'package:job_finder_app/presentation/screens/common/widgets/choose_user_type_widget.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//              const  Text(
//                 'Hi, Welcome Back!',
//                 style: AppStyle.titlesTextStyle,
//               ),
//              const  Text(
//                 'Sign in to your account.',
//                 style: AppStyle.subTitlesTextStyle,
//               ),
//               const SizedBox(height: 20,),
//              const  ChooseUserTypeWidget(),
//               const SizedBox(height: 20,),
//
//               TextFormField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ChooseUserTypeWidget extends StatefulWidget {
//    const ChooseUserTypeWidget({
//     super.key,
//   });
//
//
//   @override
//   State<ChooseUserTypeWidget> createState() => _ChooseUserTypeWidgetState();
// }
//
// class _ChooseUserTypeWidgetState extends State<ChooseUserTypeWidget> {
//   bool isJobSeeker = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: (){
//             isJobSeeker = true;
//             setState(() {
//
//             });
//           },
//           child: Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Color(0xFFF9F9FA),
//               border:  Border.all(color: isJobSeeker ? AppColors.primary : AppColors.white,width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               children: [
//                 Image.asset(AppAssets.jobSeekerIcon,height: 28,width: 28,),
//                 const SizedBox(width: 10,),
//                 Text('Job Seeker',style: AppStyle.subTitlesTextStyle.copyWith(color: AppColors.bgDark),),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 10,),
//         InkWell(
//           onTap: (){
//             isJobSeeker = false;
//             setState(() {
//
//             });
//           },
//           child: Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Color(0xFFF9F9FA),
//               border: Border.all(color:  !isJobSeeker ? AppColors.primary : AppColors.white,width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               children: [
//                 Image.asset(AppAssets.employerIcon,height: 28,width: 28,),
//                 const SizedBox(width: 10,),
//                 Text('Employer',style: AppStyle.subTitlesTextStyle.copyWith(color: AppColors.bgDark)),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = 'LoginScreen';


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    'Hi, Welcome Back!',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const Text(
                    'Sign in to your account.',
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
                    title: 'LOGIN',
                    onPressed: () {
                      AuthServices.signIn(context,
                          email: emailController.text,
                          password: passwordController.text,
                          formKey: formKey,isJobSeeker: isJobSeeker
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have account?',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                           RegisterScreen.routeName
                          );
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
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
}

