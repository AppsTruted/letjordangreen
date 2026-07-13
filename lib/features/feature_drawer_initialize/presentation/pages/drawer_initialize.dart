import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_drawer_initialize/presentation/cubits/page_view_provider.dart';
import 'package:letjordangreen/features/feature_drawer_initialize/presentation/pages/drawer_view.dart';
import 'package:letjordangreen/features/feature_home/presentation/screens/home_screen.dart';
import 'package:letjordangreen/features/feature_map/presentation/screens/map_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class DrawerInitialize extends StatefulWidget {

  @override
  State<DrawerInitialize> createState() => _DrawerInitializeState();
}

class _DrawerInitializeState extends State<DrawerInitialize> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  PageViewProvider? pageViewProvider;

  @override
  void initState() {
    super.initState();
    // _checkVersion();
    pageViewProvider = Provider.of<PageViewProvider>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final status = await Permission.location.status;
    //   sharedPreferenceClass.setIsFirstTime(false);
    //   if (!status.isGranted && Platform.isAndroid) {
    //     // show your permissions dialog here if you still need it
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: DrawerView(),
      body: Selector<PageViewProvider, PageController>(
        selector: (context, p) => p.pageController,
        builder: (context, pageController, child) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              pageViewProvider?.changeIndexNavigationBar(page);

            },
            children: const [
              HomeScreen(),
              SizedBox(),
              MapScreen()
            ],
          );
        },
      ),

      // --- Salomon Bottom Bar ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 33,right: 33),
        child: SafeArea(
          top: false,
          child: Selector<PageViewProvider, int>(
              selector: (context, listenTo) => listenTo.currentIndex,

            builder:(context, currentIndex, child)  {
              return SalomonBottomBar(
                backgroundColor: Colors.transparent,
                currentIndex: currentIndex,
                onTap: (i) {
                  if (i == 3) {
                    _scaffoldKey.currentState?.openEndDrawer();
                    return;
                  }
                  if (i == 1) {
                   context.push(AppRoutes.treeScannerScreen);
                    return;
                  }
                  if (i == 2) {
                    context.push(AppRoutes.mapScreen);
                    return;
                  }
                  pageViewProvider?.jumpToNextPage(i);
                },
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home_rounded),
                    title:  Text("Home",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),),
                    selectedColor: AppColors.primaryColor,
                    unselectedColor: Colors.black45,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.qr_code_rounded),
                    title:  Text("Plant",style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),),
                    selectedColor: AppColors.primaryColor,
                    unselectedColor: Colors.black45,
                  ),

                  SalomonBottomBarItem(
                    icon: const Icon(Icons.map),
                    title:  Text("Map", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12)),
                    selectedColor: AppColors.primaryColor,
                    unselectedColor: Colors.black45,
                  ),

                  // Drawer launcher (no page)
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.menu),
                    title:  Text("Menu"),
                    selectedColor: AppColors.primaryColor,
                    unselectedColor: Colors.black45,
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  // void _checkVersion() async {
  //   final newVersion = NewVersionPlus(
  //     androidId: "com.truted.e_commerce",
  //     iOSId: "com.truted.eCommerce",
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   if (status != null && status.canUpdate) {
  //     newVersion.showUpdateDialog(
  //       context: context,
  //       versionStatus: status,
  //       allowDismissal: false,
  //       dialogTitle: LocaleKeys.update.tr(),
  //       dismissButtonText: LocaleKeys.exit.tr(),
  //       dialogText:
  //       "${LocaleKeys.please_update_app.tr()} ${status.localVersion} ${LocaleKeys.to.tr()} ${status.storeVersion}",
  //       dismissAction: () => SystemNavigator.pop(),
  //       updateButtonText: LocaleKeys.lets_update.tr(),
  //     );
  //   }
  // }
}

