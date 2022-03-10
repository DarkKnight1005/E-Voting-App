import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voting_app/constants/color_constants.dart';
import 'package:voting_app/constants/spacing_consts.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/screens/auth/signup_screen.dart';
import 'package:voting_app/ui/widgets/buttons/primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/onboard.svg',
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SpacingConsts.kDefaultPadding + 10,
                    ),
                    child: Text(
                      'E-Voting App',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SpacingConsts.kDefaultPadding + 20,
                    left: SpacingConsts.kDefaultPadding,
                    right: SpacingConsts.kDefaultPadding,
                    ),
                    child: Text(
                     'Hold secure elections without printing costs and complicated organization. Voting will be honest and anonymous thanks to blockchain technology.'
                   ,   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 16,
                          ),textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: PrimaryButton(
                btnText: 'Get Started',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AuthScreen(),
                    ),
                  );
                },
                btnColor: ColorConstants.accentCOlor,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black, fontSize: 20,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
