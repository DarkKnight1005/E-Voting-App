import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/blocs/bloc/auth_bloc.dart';
import 'package:voting_app/ui/screens/onboarding_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
   
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
       title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      SignOutRequested(),
                    );

                print(BlocProvider.of<AuthBloc>(context).state);
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, AuthState state) {
          if (state is Unauthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
              (route) => false,
            );
          }
        },
        child: Center(
          child: Text('Hello ${user.email}'
          ),
        ),
      ),
    );
  }
}
