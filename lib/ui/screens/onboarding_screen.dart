import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/constants/spacing_consts.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/app_icon.svg',
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: SpacingConsts.kDefaultPadding + 80,
                    left: SpacingConsts.kDefaultPadding,
                    right: SpacingConsts.kDefaultPadding,
                  ),
                  child: Text(
                    'Hold secure elections with Votion. Voting will be honest and anonymous.',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: PrimaryButton(
                    btnText: 'Get Started',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    },
                    btnColor: ColorConstants.accentCOlor,
                    textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
