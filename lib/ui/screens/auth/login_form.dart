import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/providers/auth_form_notifier.dart';
import 'package:voting_app/providers/pasword_visibility_notifier.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/screens/home_screen.dart';
import 'package:voting_app/ui/screens/auth/signup_form.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';
import 'package:voting_app/utils/validators/validators.dart';
import '../../../blocs/bloc/auth_bloc.dart';
import '../../../constants/spacing_consts.dart';
import '../../widgets/textfields/custom_textfield.dart';
import 'login_form.dart';
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
          if(state is Authenticated){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
          }else if (state is AuthError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error), duration: Duration(seconds: 2),), );
      }
    }, builder: (context, AuthState state) {
      if (state is AuthLoading) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
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
              _buildEmailFIeld(),
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

  Widget _buildTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t you have an account?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthFormNotifier>().isLoginForm = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthScreen()));
          },
          child: const Text(
            'Register',
            style: TextStyle(
              color: ColorConstants.primaryCOlor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Center(
      child: PrimaryButton(
        btnText: 'Login',
        onPressed: () {
          _signIn();
          debugPrint(context.read<AuthBloc>().state.toString());
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextfield(
      controller: passwordController,
      isPassword: true,
      focusNode: passwordFocusNode,
      textInputAction: TextInputAction.done,
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
    );
  }

  Widget _buildEmailFIeld() {
    return CustomTextfield(
      controller: emailController,
      labelText: 'Email',
      focusNode: loginFocusNode,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        Icons.email_rounded,
        color: Colors.grey[600],
      ),
      validator: (val) {
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
      'Login',
      style: TextStyle(
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
