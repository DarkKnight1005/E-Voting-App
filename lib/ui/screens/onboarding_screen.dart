import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voting_app/constants/spacing_consts.dart';
import 'package:voting_app/ui/screens/auth/auth_screen.dart';
import 'package:voting_app/ui/screens/auth/signup_screen.dart';

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
              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.15,),
              child: Column(
                children: [
                SvgPicture.asset('assets/images/onboard/svg', width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.5),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: SpacingConsts.kDefaultPadding + 10,
                    ),
                    child: Text(
                      'E-Voting App',
                      style:  TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SpacingConsts.kDefaultPadding + 20,
                    ),
                    child: Text('Lorem Imspum sjjdjfjjf', style:TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[600],)),
                  ),
                ],
              ),
            ),
          ),
         
          Flexible(flex:1,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingConsts.kDefaultPadding * 5,
                      vertical: SpacingConsts.kDefaultPadding - 3,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AuthScreen()));
                },
                child: const Text('Get Started'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
