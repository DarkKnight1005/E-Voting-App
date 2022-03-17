import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/blocs/bloc/auth_bloc.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/screens/home_screen.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
    }

    timer = Timer.periodic(Duration(seconds: 3), (_) {
      checkEmailVerified();
    });
    super.initState();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomeScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text('Verify Email Address'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'An email has been sent to your email address. Please check.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                PrimaryButton(
                  btnText: 'Resend email',
                  onPressed: canResendEmail ? sendVerificationEmail : () {},
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: PrimaryButton(
                      btnText: 'Cancel',
                      btnColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.primaryCOlor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AuthScreen()));
                 print(       context.read<AuthBloc>().state);
                      }),
                ),
              ],
            ),
          );
  }
}
