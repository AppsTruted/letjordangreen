import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/hive/Hive_class.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/features/feature_auth/feature_check_token/cubit/check_token_cubit.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  // final player = AudioPlayer();

  playSound() async {
  //  await player.play(AssetSource('audio/voice-2.mp3'));
  }

  @override
  void initState() {
    super.initState();
    playSound();
    // _controller = VideoPlayerController.asset('assets/mp4/bronqr_icon_1.mp4')
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play();
    //   });
   // _controller.setLooping(true);

    // getUserCurrentLocation().then((location) async {
      // if (mounted) {
      //   context.read<CheckOutCubit>().setCurrentLocation(LatLng(location!.latitude, location.longitude));
      //   getAddressFromCoordinates(location).then((onValue) {
      //     context.read<CheckOutCubit>().setAddress(onValue??"");
      //   });
      //       }
    // });

  _initSplashSequence();
  }

  Future<void> _initSplashSequence() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    // await _checkVersion();
   _handleUserLogic();
  }

  Future<void> _handleUserLogic() async {
    UserBox.getInstance();

    final userBox = await UserBox.getUserBox();
    final userData = userBox?.get("user");

    log("userData $userData ${userData != null}");
    if (userData != null) {
      if (!mounted) return;

      final userInformationCubit = context.read<UserInformationCubit>();
      userInformationCubit.setUserHiveModel(userData, userData.password!);

      final checkTokenCubit = context.read<CheckTokenCubit>();

      // final bool isDevice = (userData.roles?.contains("device") ?? false);
      // final bool isSales = (userData.roles?.contains("sales") ?? false);


      final tokenResult =  await checkTokenCubit.getCheckToken(context);

      debugPrint('Token value: ${tokenResult.status}');

      if (!mounted) return;

      if (tokenResult.status == "JWT Valid!") {
        log("tokenResult.status == JWT valid");
        context.go( AppRoutes.initializeHome );

      } else {
      //  userInformationCubit.logout(context);
      //   context.go(AppRoutes.rememberedSplashScreen);
       context.go( AppRoutes.loginWithEmail );
      }
    } else {
      if (!mounted) return;
    //  context.go( AppRoutes.loginWithEmail );
      context.go(AppRoutes.initializeHome);
    }
  }

  Future<void> _checkVersion() async {
    final newVersionPlus = NewVersionPlus(
      androidId: "com.truted.hyvermenu",
      iOSId: "6747781202",
    );

    final status = await newVersionPlus.getVersionStatus();

    if (status != null && status.canUpdate) {
      log("DEVICE : ${status.localVersion}");
      log("STORE : ${status.storeVersion}");

      newVersionPlus.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: true,
        launchModeVersion: LaunchModeVersion.external,
        dialogTitle: "Update required",
        dismissButtonText: "Close",
        dialogText: "A new version is available.",
        updateButtonText: "Update",
        dismissAction: () {
          _handleUserLogic();
        },
      );
    } else {
      await _handleUserLogic();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return _controller.value.isInitialized
    //     ? Container(
    //   color: Color(0xff05DBFC),
    //   child: FittedBox(
    //     fit: BoxFit.contain,
    //     child: SizedBox(
    //       width: _controller.value.size.width,
    //       height: _controller.value.size.height,
    //       child: VideoPlayer(_controller),
    //     ),
    //   ),
    // )
    //     : const SizedBox();
    return Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/img/background-splash.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height,
          ),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.55),
                ],
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: Container(
            color: const Color(0xff0b3b2b).withOpacity(0.18),
          ),
        ),

        Align(
          alignment: const Alignment(0, -0.37),
          child: Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 1.2,
              ),
              color: Colors.white.withOpacity(0.06),
            ),
            child: Center(
              child: CircularProgressIndicator(),
              // child: CustomPaint(
              //   size: const Size(34, 38),
              //   painter: TreeLogoPainter(),
              // ),
            ),
          ),
        ),

        Align(
          alignment: const Alignment(0, -0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                'Let Jordan Green'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.1,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Restoring landscapes, building\nfutures.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),

        Align(
          alignment: const Alignment(0, 0.30),
          child: Container(
            width: 150,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        Align(
          alignment: const Alignment(0, 0.45),
          child: Text(
            'LAUNCHING PLATFORM',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 4.2,
            ),
          ),
        ),
        Positioned(
          bottom: 38,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 13,
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(width: 7),
              Text(
                'Secure Ecological Ledger',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}

class TreeLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final top = Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w * 0.18, h * 0.42)
      ..lineTo(w * 0.36, h * 0.42)
      ..lineTo(w * 0.12, h * 0.68)
      ..lineTo(w * 0.88, h * 0.68)
      ..lineTo(w * 0.64, h * 0.42)
      ..lineTo(w * 0.82, h * 0.42)
      ..close();

    final trunk = Rect.fromLTWH(
      w * 0.43,
      h * 0.66,
      w * 0.14,
      h * 0.24,
    );

    canvas.drawPath(top, paint);
    canvas.drawRect(trunk, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}