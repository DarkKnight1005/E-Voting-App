import 'package:flutter/material.dart';
import 'package:voting_app/providers/auth_form_notifier.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/ui/screens/auth/signup_screen.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthFormNotifier>(
      create: (_) =>  AuthFormNotifier(),
    
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                
                ),
                child: SignupForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
