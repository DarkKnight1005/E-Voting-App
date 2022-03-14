import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/blocs/bloc/auth_bloc.dart';
import 'package:voting_app/cloud/repositories/auth_repository.dart';
import 'package:voting_app/config/app_theme.dart';
import 'package:voting_app/providers/auth_form_notifier.dart';
import 'package:voting_app/ui/screens/home_screen.dart';
import 'package:voting_app/ui/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

class VotingApp extends StatelessWidget {
  const VotingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthFormNotifier>(
          create: (_) => AuthFormNotifier(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: AuthRepository()),
        child: (MaterialApp(
          theme: AppTheme.theme,
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
      ),
    );
  }
}
