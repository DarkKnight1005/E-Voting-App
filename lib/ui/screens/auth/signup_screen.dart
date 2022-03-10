import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';
import 'package:voting_app/utils/validators/validators.dart';
import '../../../blocs/bloc/auth_bloc.dart';
import '../../../constants/spacing_consts.dart';
import '../../../providers/auth_form_notifier.dart';
import '../../../providers/pasword_visibility_notifier.dart';
import '../home_screen.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _signUp() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequestedEvent(
          emailController.text.trim(),
          passwordController.text.trim(),
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, AuthState state) {
      if (state is Authenticated) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      }
    }, builder: (context, AuthState state) {
      if (state is AuthLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
          left: SpacingConsts.kDefaultPadding + 5,
          right: SpacingConsts.kDefaultPadding + 5,
          bottom: SpacingConsts.kDefaultPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset('assets/images/signup.svg',
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Create an account',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailController,
                validator: (val) {
                  if (val != null && val.isEmpty) {
                    return 'Please enter a valid email';
                  } else if (!(val!.isValidEmail())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Email address'),
              ),
              const SizedBox(
                height: 20,
              ),
              ChangeNotifierProvider<PasswordVisibilityNotifier>(
                create: (_) => PasswordVisibilityNotifier(),
                child: Consumer<PasswordVisibilityNotifier>(
                    builder: (context, PasswordVisibilityNotifier notifier, _) {
                  return TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: notifier.isVisible,
                    
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      if (!(val!.isValidPassword())) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      prefixIcon: const Icon(Icons.password_outlined),
                      hintText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: (){notifier.toggleVisibility();},
                        child: notifier.isVisible ?  Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                  child: PrimaryButton(
                btnText: 'Sign up',
                onPressed: () {
                  _signUp();
                  print(context.read<AuthBloc>().state);
                },
              )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthFormNotifier>().isLoginForm =true;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: const TextStyle(
                        fontSize: 18,
                        color: ColorConstants.primaryCOlor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
