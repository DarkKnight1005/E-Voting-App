import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/providers/auth_form_notifier.dart';
import 'package:voting_app/providers/pasword_visibility_notifier.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/screens/home_screen.dart';
import 'package:voting_app/ui/screens/auth/signup_screen.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';
import 'package:voting_app/utils/validators/validators.dart';
import '../../../blocs/bloc/auth_bloc.dart';
import '../../../constants/spacing_consts.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _signIn() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequestedEvent(
          emailController.text,
          passwordController.text,
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
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
    
        }
    , builder: (context, AuthState state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } return 
          SingleChildScrollView(
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
                child: SvgPicture.asset('assets/images/login.svg',
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3),
              ),
              const SizedBox(
                height: 20,
              ),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return 'Please enter a valid email';
                      }else if (!(val!.isValidEmail())) {
                    return 'Please enter a valid email';
                  }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Email address'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ChangeNotifierProvider<PasswordVisibilityNotifier>(
                    create:(_) => PasswordVisibilityNotifier(),
                    child: Consumer<PasswordVisibilityNotifier>(
                      builder: (context, PasswordVisibilityNotifier notifier, _) {
                    return TextFormField(
                     autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: notifier.isVisible,
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return 'Please enter a valid password';
                          }  if (!(val!.isValidPassword())) {
                        return 'Password should be at least 6 characters long';
                      }
                          return null;
                        },
                        decoration: InputDecoration(  suffixIcon: GestureDetector(
                        onTap: (){notifier.toggleVisibility();},
                        child: notifier.isVisible ?  Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                            prefixIcon: Icon(Icons.password_outlined),
                            hintText: 'Password'),
                      );}
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: PrimaryButton(btnText: 'Login',
                      onPressed: () {
                        _signIn();
                        debugPrint(context.read<AuthBloc>().state.toString());
                      },
                     
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t you have an account?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthFormNotifier>().isLoginForm = false;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AuthScreen()));
                      
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color:ColorConstants.primaryCOlor,
                            fontSize: 18,
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
        
    }
    );
  }
}
