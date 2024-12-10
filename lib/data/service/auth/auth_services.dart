import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/app_user.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/login_screen/login_screen.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/employer_home_screen.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_profile_screen/employer_profile_screen.dart';
import 'package:job_finder_app/presentation/screens/home_test.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/job_seeker_home_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_profile_screen/job_seeker_profile_screen.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';
import 'package:job_finder_app/utils/shared_pref_utils.dart';

abstract class AuthServices {
  static void signIn(BuildContext context,
      {required String email,
      required String password,
      required GlobalKey<FormState> formKey,
      required bool isJobSeeker}) async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.uid);
      if (context.mounted) {
        hideDialog(context);
        await checkUserRole(isJobSeeker, userCredential, context);
      }
    } on FirebaseAuthException catch (authError) {
      if (context.mounted) {
        hideDialog(context);
      }

      String errorMessage = "";
      if (authError.code == 'channel-error') {
        errorMessage =
            "${authError.message ?? "something went wrong please later"} ";
      } else {
        print(authError.code);
        errorMessage = "Wrong email or password Pleas double your creds.";
      }

      if (context.mounted) {
        showMessage(context,
            title: 'Error', body: errorMessage, posButtonTitle: 'ok');
      }
    } catch (error) {
      print('Error $error');
      if (context.mounted) {
        hideDialog(context);
        showMessage(context,
            title: 'Error',
            body: 'something went wrong please later',
            posButtonTitle: 'ok');
      }
    }
  }

  static Future<void> checkUserRole(bool isJobSeeker,
      UserCredential userCredential, BuildContext context) async {
    if (isJobSeeker) {
      dynamic jobSeeker = await JobSeekerServices.getJobSeekerFromFireStore(
          userCredential.user!.uid);
      if (jobSeeker == null) {
        showMessage(
          context,
          title: 'Error',
          body: 'You must chooise corect user',
          posButtonTitle: 'ok',
        );
        print('not user');
        return;
      } else {
        JobSeeker.currentJobSeeker = jobSeeker;

        SharedPrefUtils().saveUser(
          AppUser(
            id: userCredential.user!.uid,
            email: userCredential.user!.email,
            name: JobSeeker.currentJobSeeker!.name,
            isJobSeeker: true,
          ),
        );
        Navigator.pushReplacementNamed(
          context,
          JobSeekerHomeScreen.routeName,
        );
      }
    } else {
      dynamic employer = await EmployerServices.getEmployerFromFireStore(
          userCredential.user!.uid);
      if (employer == null) {
        showMessage(
          context,
          title: 'Error',
          body: 'You must chooise corect user',
          posButtonTitle: 'ok',
        );
        print('not user');
        return;
      } else {
        Employer.currentEmployer = employer;

        SharedPrefUtils().saveUser(
          AppUser(
            id: userCredential.user!.uid,
            email: userCredential.user!.email,
            name: Employer.currentEmployer!.name,
            isJobSeeker: false,
          ),
        );
        Navigator.pushReplacementNamed(
          context,
          EmployerHomeScreen.routeName,
        );
      }
    }
  }

  static void createAccount(BuildContext context,
      {required String email,
      required String password,
      required GlobalKey<FormState> formKey,
      required bool isJobSeeker}) async {
    if (!formKey.currentState!.validate()) return;

    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // AppUser user =
      // AppUser(id: userCredential.user!.uid, name: username, email: email);
      // await addUserToFireStore(user);
      // AppUser.currentUser = user;
      if (context.mounted) {
        hideDialog(context);
        // showMessage(context,
        //     title: 'Success',
        //     body: 'Account created succesfully',
        //     posButtonTitle: 'ok');
        if (isJobSeeker) {
          Navigator.pushReplacementNamed(
            context,
            JobSeekerProfileScreen.routeName,
            arguments: userCredential,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            EmployerProfileScreen.routeName,
            arguments: userCredential,
          );
        }
      }
    } on FirebaseAuthException catch (authError) {
      if (context.mounted) {
        hideDialog(context);
      }

      String errorMessage = "";
      if (authError.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
        // showMessage(context,
        //     title: 'Error', body: 'The password provided is too weak.');
      } else if (authError.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
        // showMessage(context,
        //     title: 'Error', body: 'The account already exists for that email.');
      } else {
        errorMessage =
            "${authError.message ?? "something went wrong please later"} ";
        // showMessage(context,
        //     title: 'Error',
        //     body: '${authError.message} ?? something went wrong please later');
      }

      if (context.mounted) {
        showMessage(context,
            title: 'Error', body: errorMessage, posButtonTitle: 'ok');
      }
    } catch (error) {
      print('Error $error');
      if (context.mounted) {
        hideDialog(context);
        showMessage(context,
            title: 'Error',
            body: 'something went wrong please later',
            posButtonTitle: 'ok');
      }
    }
  }

  static void logout(bool isJobSeekerRole, BuildContext context) {
    if (isJobSeekerRole) {
      JobSeeker.currentJobSeeker = null;
    } else {
      Employer.currentEmployer = null;
    }
    SharedPrefUtils.removeData();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
