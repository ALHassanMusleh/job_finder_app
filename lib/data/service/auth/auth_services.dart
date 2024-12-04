import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/presentation/screens/home_test.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';

abstract class AuthServices {
  static void signIn(BuildContext context,
      {required String email,
      required String password,
      required GlobalKey<FormState> formKey}) async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.uid);
      if (context.mounted) {
        hideDialog(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeTest()));
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

  static void createAccount(BuildContext context,
      {required String email,
      required String password,
      required GlobalKey<FormState> formKey}) async {
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeTest()));
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
}
