import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/hive/Hive_class.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/cubit/login_cubit.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:letjordangreen/widgets/show_message.dart';

class RememberedSplash extends StatefulWidget {
  const RememberedSplash({super.key});

  @override
  State<RememberedSplash> createState() => _RememberedSplashState();
}

class _RememberedSplashState extends State<RememberedSplash> {
  UserInformationCubit? userInformationCubit = UserInformationCubit();
   UserHiveModel? userHiveModel;

  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  getSavedData() async {
    final userBox = await UserBox.getUserBox();
    final userData = userBox?.get("user");
    if (userData != null) {
      if (!mounted) return;

      final userInformationCubit = context.read<UserInformationCubit>();
      userInformationCubit.setUserHiveModel(userData, userData.password!);
      userHiveModel = userInformationCubit.state.userHiveModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/png/icon.png", height: 60, color: AppColors.secondaryColor,),
              Image.asset("assets/png/logo.png",height: 34, color: AppColors.secondaryColor,),
            ],
          ),


          const SizedBox(height: 40),

          Text("WELCOME BACK", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),),

          Text(userHiveModel?.name?.toUpperCase() ?? "Device", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 26, fontFamily: "ClashDisplay",),),

          const SizedBox(height: 60),

          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(0.25),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size.fromHeight(42),
              ),
              onPressed: () => signIn(),
              child: BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.status == LoginStatus.success) {
                       successFunction();
                  }
                },
                child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state.status == LoginStatus.loading || state.status == LoginStatus.submitting) {
                        return const CircularProgressIndicator(color: AppColors.primaryColor, strokeWidth: 2,);
                      }

                      if (state.status == LoginStatus.initial || state.status == LoginStatus.error){
                        return  Text("Log in",style: Theme.of(context).textTheme.bodyMedium);
                      }

                      return const SizedBox();

                    }),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.withOpacity(.25))),
                  minimumSize: const Size.fromHeight(42),
                ),
                onPressed: () =>   context.push(AppRoutes.login),
                child: Text("Log into another account",style: Theme.of(context).textTheme.bodyMedium)),
          ),
          const SizedBox(height: 40),

        ],
      ),
    );
  }

  signIn() {
    final bool isDevice = (userHiveModel?.roles?.contains("device") ?? false);
    // final bool isSales = (userHiveModel.roles?.contains("sales") ?? false);

    log("isDevice ${userHiveModel?.username} ${userHiveModel?.password} $isDevice");

    if(userHiveModel?.username?.isNotEmpty ?? false) {
      context.read<LoginCubit>().setEmail(userHiveModel!.username!);
      context.read<LoginCubit>().setPassword(userHiveModel!.password!);
      if(isDevice) {
        context.read<LoginCubit>().loginWithCredentials(context: context);
      }
      else {
        context.read<LoginCubit>().loginWithCredentials(context: context);
      }
    }
    else {
      showMessage("Please sign in again", true);
    //  context.push(AppRoutes.loginTypeScreen);
    }
  }

  successFunction() {
    final bool isDevice = (userHiveModel?.roles?.contains("device") ?? false);
    final bool isSales = (userHiveModel?.roles?.contains("sales") ?? false);
    if(isSales) {
  //    context.go( AppRoutes.navigationSalesScreen );
    }
    else {
      // context.read<RestaurantByIdCubit>().getRestaurantBytId();
      // context.read<AppearanceCubit>().getAppearance();
      // context.read<BranchesCubit>().getRestaurantBranches().then((branches) {
      //
      //   putUserInfo(context, branchId: branches.first.id);
      //   context.read<CheckOutCubit>().setBranch(branches.first);
      //
      //   if(isDevice && userHiveModel!.deviceType!.toLowerCase().contains("menu")) {
      //     context.go(AppRoutes.allBranchesScreen);
      //   }
      //   else {
      //     context.go(AppRoutes.navigationHomeScreen);
      //   }
      // });
    }
  }

}