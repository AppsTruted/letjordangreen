import 'package:flutter/material.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_profile/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  final String fromPage;
  const ProfileImage(this.fromPage, {super.key});

  @override
  Widget build(BuildContext context) {

    return  Align(alignment: Alignment.center,
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Stack(
            children: [

              InkWell(
                child: Container(
                    height: 110,
                    width: 110,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,

                      borderRadius:  BorderRadius.all(Radius.circular(8))
                  ),
                  child: fromPage == "drawer"?
                  Image.asset("assets/images/image.png") :
                  Center(
                      child:( profileProvider.firstLetter == "+" || profileProvider.secondLetter =="+" ) ||
                          ( profileProvider.firstLetter == "" || profileProvider.secondLetter =="")
                          ?
                      Icon(Icons.person,size: 100,color: Colors.white) :

                      Text(
                      "${profileProvider.firstLetter.toUpperCase()}${profileProvider.secondLetter.toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                      ))
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
