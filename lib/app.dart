import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/blocs/bloc/auth_bloc.dart';
import 'package:voting_app/cloud/repositories/auth_repository.dart';
import 'package:voting_app/wrapper.dart';

class VotingApp extends StatelessWidget {
  const VotingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: (const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        )),
      ),
    );
  }
}
