import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voting_app/blocs/bloc/auth_bloc.dart';
import 'package:voting_app/cloud/repositories/auth_repository.dart';

void main() {
  group('Auth Bloc Tests', (){
    AuthBloc mockAuthBloc = AuthBloc(authRepository: AuthRepository());
   late AuthBloc authBloc;
   late AuthRepository authRepository;
   String email = 'sevar1@gmail.com';
   String password = 'sevar2@gmail.com';

   setUp(() async{
await Firebase.initializeApp();
     EquatableConfig.stringify = true;
     authRepository =  AuthRepository();
     authBloc = AuthBloc(authRepository: authRepository);
   });

   blocTest<AuthBloc, AuthState>(
     'emits [AuthLoading] when SignupEvent is added.',
     build: () => mockAuthBloc,
     act: (AuthBloc bloc) => bloc.add(SignUpRequestedEvent(email, password)),
     expect: () =>  <AuthState>[AuthLoading(), Authenticated()],
   );
   tearDown((){
     authBloc.close();
   });
  });

}