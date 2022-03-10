import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/blocs/bloc/auth_bloc.dart';
import 'package:voting_app/cloud/repositories/auth_repository.dart';
import 'package:voting_app/ui/screens/home_screen.dart';

import 'package:voting_app/ui/screens/onboarding_screen.dart';


class VotingApp extends StatelessWidget {
  const VotingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return OnboardingScreen();
          },
        ),
      )),
    );
  }
}
