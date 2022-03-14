import 'package:flutter/material.dart';
import 'package:voting_app/providers/pasword_visibility_notifier.dart';
import 'package:provider/provider.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.focusNode,
    this.labelStyle,
    required this.textInputAction,
  required  this.validator,
    this.isPassword = false,
    this.needAutoFocus = false,
  }) : super(key: key);

  final String labelText;
  final TextStyle? labelStyle;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Widget prefixIcon;
  final bool isPassword;
  final bool needAutoFocus;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PasswordVisibilityNotifier>(
      create: (context) => PasswordVisibilityNotifier(),
      child: Consumer<PasswordVisibilityNotifier>(
          builder: (context, PasswordVisibilityNotifier notifier, child) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          obscureText: isPassword ? notifier.isVisible : false,
          focusNode: focusNode,
          autofocus: needAutoFocus,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: labelStyle ??
                const TextStyle(
                  fontSize: 20,
                ),
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: () {
                      notifier.toggleVisibility();
                    },
                    child: notifier.isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            errorStyle: const TextStyle(
              fontSize: 15,
              color: Colors.red,
            ),
          ),
        );
      }),
    );
  }
}
