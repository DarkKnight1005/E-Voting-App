
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting_app/ui/screens/home_screen.dart';
import 'package:voting_app/utils/validators/validators.dart';
import '../../../blocs/bloc/auth_bloc.dart';
import '../../../constants/spacing_consts.dart';
import 'login_screen.dart';


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
      // if (state is Authenticated) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => HomeScreen()),
      //       (route) => false);
      // }
    }, builder: (context, AuthState state) {
      if (state is AuthLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: SpacingConsts.kDefaultPadding + 20 ,
            left: SpacingConsts.kDefaultPadding + 5,
            right: SpacingConsts.kDefaultPadding + 5,
            bottom: SpacingConsts.kDefaultPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField( autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    else if(!(val!.isValidEmail())){
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
                TextFormField( autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return 'Please enter a valid password';
                    }
                    if(!(val!.isValidPassword())){
                      return 'Password should be at least 6 characters long';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined),
                      hintText: 'Password',),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(
                          horizontal: SpacingConsts.kDefaultPadding * 5,
                          vertical: SpacingConsts.kDefaultPadding - 3,
                        ),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    onPressed: () {
                      _signUp();
                      print(context.read<AuthBloc>().state);
                    },
                    child: Text('Sign up'),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
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
     
     
    });
  }
}
