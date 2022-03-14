import 'package:flutter/material.dart';
import 'package:voting_app/constants/color_constants.dart';

import '../../../constants/spacing_consts.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.btnColor = ColorConstants.primaryCOlor,
    required this.btnText,
    this.borderRadius = 15.0,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);
  final Color btnColor;

  final String btnText;
  final double borderRadius;
  final TextStyle? textStyle;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingConsts.kDefaultPadding * 5,
          vertical: SpacingConsts.kDefaultPadding,
        ),
      
      ),
      onPressed:  onPressed,
      child: Text(btnText, style: textStyle ?? const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),),
    );
  }
}
