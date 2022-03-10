import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/ui/screens/auth/login_screen.dart';
import 'package:voting_app/ui/screens/home_screen.dart';


import 'blocs/bloc/auth_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      builder: (BuildContext context, AuthState state) {
        print(state);
        if (state is AuthLoading) {
          return CircularProgressIndicator.adaptive();
        }
        if (state is Unauthenticated) {
          return LoginScreen();
        }
        return Scaffold(body: Container(color: Colors.red));
      },
    );
  }
}
