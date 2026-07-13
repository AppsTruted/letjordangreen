import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:letjordangreen/core/functions/dissmiss_keybooard.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/presentation/widgets/signup_card.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupCardWidget();
      GestureDetector(
      onTap: unFocusKeyBoard(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
      //    leading: const BackArrowWidget(),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffBFE3F6),
                  Color(0xffE3F2FB),
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding:  const EdgeInsets.all(24),
              child: signupBody(context),
            ),
          )
      ),
    );
  }

  Widget signupBody(BuildContext context){
    return ListView(
      children:   [

        SignupCardWidget(),


      ],
    );
  }
}