import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';
import 'package:voting_app/ui/widgets/textfields/custom_textfield.dart';
import 'package:voting_app/utils/validators/validators.dart';
import '../../../blocs/bloc/auth_bloc.dart';
import '../../../constants/spacing_consts.dart';
import '../../../providers/auth_form_notifier.dart';
import '../../../providers/pasword_visibility_notifier.dart';
import '../home_screen.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode loginFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    loginFocusNode.dispose();
    passwordFocusNode.dispose();
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
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
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
          left: SpacingConsts.kDefaultPadding + 10,
          right: SpacingConsts.kDefaultPadding + 10,
          bottom: SpacingConsts.kDefaultPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLogo(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              _buildTitle(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              _buildEmailField(),
              const SizedBox(
                height: 10,
              ),
              _buildPasswordField(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              _buildButton(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              _buildTextButton(context),
            ],
          ),
        ),
      );
    });
  }

  Center _buildButton(BuildContext context) {
    return Center(
        child: PrimaryButton(
      btnText: 'Sign up',
      onPressed: () {
        _signUp();
        print(context.read<AuthBloc>().state);
      },
    ));
  }

  Widget _buildTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthFormNotifier>().isLoginForm = true;
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
    );
  }

  Widget _buildPasswordField() {
    return CustomTextfield(
      controller: passwordController,
      textInputAction: TextInputAction.done,
      isPassword: true,
      validator: (val) {
        if (val != null && val.isEmpty) {
          return 'Please enter a valid password';
        }
        if (!(val!.isValidPassword())) {
          return 'Password should be at least 6 characters long';
        }
        return null;
      },
      prefixIcon: Icon(
        Icons.password_rounded,
        color: Colors.grey[600],
      ),
      labelText: 'Password',
      focusNode: passwordFocusNode,
    );
  }

  Widget _buildEmailField() {
    return CustomTextfield(
      controller: emailController,
      focusNode: loginFocusNode,
      textInputAction: TextInputAction.next,
      labelText: 'Email',
      prefixIcon: Icon(
        Icons.email_rounded,
        color: Colors.grey[600],
      ),
      validator: (val) {
        print(val);
        if (val != null && val.isEmpty) {
          return 'Please enter a valid email';
        } else if (!(val!.isValidEmail())) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Signup',
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 100,
        height: 100,
      ),
    );
  }
}
