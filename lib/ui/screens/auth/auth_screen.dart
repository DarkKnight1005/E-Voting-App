import 'package:flutter/material.dart';
import 'package:voting_app/providers/auth_form_notifier.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/ui/screens/auth/login_form.dart';
import 'package:voting_app/ui/screens/auth/signup_form.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          
          
          
          child: context.read<AuthFormNotifier>().isLoginForm ? LoginForm() : SignupForm(),
        ),
    
    );
  }
}
