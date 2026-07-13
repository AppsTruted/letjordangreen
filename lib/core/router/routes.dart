import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/cubit/login_cubit.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/presentation/screens/login_screen.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/cubit/signup_cubit.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/presentation/processing/signup_provider.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/presentation/screens/signup_screen.dart';
import 'package:letjordangreen/features/feature_auth/feature_splash/presentation/splash_screen.dart';
import 'package:letjordangreen/features/feature_drawer_initialize/presentation/pages/drawer_initialize.dart';
import 'package:letjordangreen/features/feature_farmer_supply_orders/cubits/farmer_supply_orders_cubit.dart';
import 'package:letjordangreen/features/feature_farmer_supply_orders/presentation/screens/farmer_supply_orders_screen.dart';
import 'package:letjordangreen/features/feature_inspection_queue/presentation/screens/inspection_queue_screen.dart';
import 'package:letjordangreen/features/feature_map/cubit/tree_cubit.dart';
import 'package:letjordangreen/features/feature_map/presentation/screens/map_screen.dart';
import 'package:letjordangreen/features/feature_profile/cubits/edit_user_profile_cubit/edit_user_profile_cubit.dart';
import 'package:letjordangreen/features/feature_profile/presentation/edit_profile_view.dart';
import 'package:letjordangreen/features/feature_projects/presentation/screens/all_projects_screen.dart';
import 'package:letjordangreen/features/feature_scan_qr/cubits/image_picker_cubit.dart';
import 'package:letjordangreen/features/feature_scan_qr/presentation/screens/scan_qr_screen.dart';
import 'package:provider/provider.dart';


import 'custom_page_transition.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  errorBuilder: (context, state) => SizedBox(),
  routes: [
    // GoRoute(
    //   path: AppRoutes.homeScreen,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: DrawerInitialize(),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    // ),

    GoRoute(
      path: AppRoutes.splashScreen,
      pageBuilder: (context, state) =>
          CustomTransitionPage<void>(
            key: state.pageKey,
            child: SplashScreen(),
            transitionsBuilder: buildTransition,
          ),

    ),
    // GoRoute(
    //   path: AppRoutes.onBoardingScreen,
    //   pageBuilder: (context, state) => CustomTransitionPage<void>(
    //     key: state.pageKey,
    //     child: OnBoardingScreen(),
    //     transitionsBuilder: buildTransition,
    //   ),
    //
    // ),

    GoRoute(
      path: AppRoutes.initializeHome,
      pageBuilder: (context, state) =>
          CustomTransitionPage<void>(
            key: state.pageKey,
            child: DrawerInitialize(),
            transitionsBuilder: buildTransition,
          ),

    ),
    GoRoute(
      path: AppRoutes.inspectionQueueScreen,
      pageBuilder: (context, state) =>
          CustomTransitionPage<void>(
            key: state.pageKey,
            child: InspectionQueueScreen(),
            transitionsBuilder: buildTransition,
          ),

    ),


    GoRoute(
      path: AppRoutes.farmerSupplyOrders,
      pageBuilder: (context, state) =>
          CustomTransitionPage<void>(
            key: state.pageKey,
            child: FarmerSupplyOrdersScreen(),
            transitionsBuilder: buildTransition,
          ),

    ),
    // GoRoute(
    //   path: AppRoutes.notificationDetailsScreen,
    //   pageBuilder: (context, state) {
    //     final notification = state.extra as NotificationsModel;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: NotificationDetailsScreen(notification: notification),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    //
    // GoRoute(
    //   path: AppRoutes.restaurantProductsScreen,
    //   pageBuilder: (context, state) {
    //     final card = state.extra as LoyaltyCardsModel;
    //    return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: RestaurantProductsScreen(card: card),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    // GoRoute(
    //   path: AppRoutes.frequentVisitsScreen,
    //   pageBuilder: (context, state) {
    //   //  final card = state.extra as LoyaltyCardsModel;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: FrequentVisitsScreen(),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    //
    // GoRoute(
    //   path: AppRoutes.frequentVisitsDetailsScreen,
    //   pageBuilder: (context, state) {
    //      final restaurantId = state.extra as RestaurantsModel;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: FrequentVisitsDetailsScreen(restaurantId: restaurantId),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    //
    // GoRoute(
    //   path: AppRoutes.serveMeByScanProductIdScreen,
    //   pageBuilder: (context, state) {
    //    final scannedValue = state.extra as RedemptionSuccessDataWithProduct;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: BlocProvider(
    //           create: (context) => GetProductCubit(),
    //           child: ServeMeByScanProductIdScreen(redemptionSuccessDataWithProduct: scannedValue),
    //         ),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    //
    // GoRoute(
    //   path: AppRoutes.myUniversalCardScreen,
    //   pageBuilder: (context, state) => CustomTransitionPage<void>(
    //     key: state.pageKey,
    //     child: MyUniversalCardScreen(),
    //     transitionsBuilder: buildTransition,
    //   ),
    //
    // ),
    //
    // // GoRoute(
    // //   path: AppRoutes.loyaltyCardsScreen,
    // //   pageBuilder: (context, state) => CustomTransitionPage<void>(
    // //     key: state.pageKey,
    // //     child: LoyaltyCardsScreen(),
    // //     transitionsBuilder: buildTransition,
    // //   ),
    // //
    // // ),
    // GoRoute(
    //   path: AppRoutes.seeAllUpComingMatches,
    //   pageBuilder: (context, state) {
    //   //  final appearance = state.extra as Appearance;
    //    return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: SeeAllUpComingMatchesScreen(),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    // GoRoute(
    //   path: AppRoutes.seeAllLiveMatches,
    //   pageBuilder: (context, state) {
    //     //  final appearance = state.extra as Appearance;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: SeeAllLiveMatchesScreen(),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    // GoRoute(
    //   path: AppRoutes.carouselDetailsScreen,
    //   pageBuilder: (context, state) {
    //      final cafe = state.extra as AllStoresModel;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: CarouselDetailsScreen(cafe: cafe,),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    //
    // GoRoute(
    //   path: AppRoutes.seeAllCategoryMatchesScreen,
    //   pageBuilder: (context, state) {
    //      final id = state.extra as String;
    //     return CustomTransitionPage<void>(
    //       key: state.pageKey,
    //       child: SeeAllCategoryMatchesScreen(catId: id),
    //       transitionsBuilder: buildTransition,
    //     );
    //   },
    //
    // ),
    //
    //
    // GoRoute(
    //   path: AppRoutes.allCategoriesScreen,
    //   pageBuilder: (context, state) => CustomTransitionPage<void>(
    //     key: state.pageKey,
    //     child: AllCategoriesScreen(),
    //     transitionsBuilder: buildTransition,
    //   ),
    //
    // ),
    GoRoute(
      path: AppRoutes.loginWithEmail,
      pageBuilder: (context, state) =>
          CupertinoPage<void>(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginScreen(),
            ),
          ),
    ),
    GoRoute(
      path: AppRoutes.signup,
      pageBuilder: (context, state) =>
          CupertinoPage<void>(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [BlocProvider(create: (context) => SignupCubit())],
              child: MultiProvider(providers: [
                ChangeNotifierProvider(create: (_) => SignupProvider()),
              ], child: const SignupScreen()),
            ),
          ),
    ),

    //
    //
    GoRoute(
        path: AppRoutes.treeScannerScreen,
        pageBuilder: (context, state) {
          return CupertinoPage<void>(
            key: state.pageKey,
            child: TreeScannerScreen(),
          );
        }
    ),

    GoRoute(
      path: AppRoutes.allProjectsScreen,
      pageBuilder: (context, state) {
        return CupertinoPage<void>(
          key: state.pageKey,
          child: AllProjectsScreen(),
        );
      },
    ),
    //
    GoRoute(
      path: AppRoutes.mapScreen,
      pageBuilder: (context, state) {
        return CupertinoPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => TreeCubit(),
            child: MapScreen(),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editProfileScreen,
      pageBuilder: (context, state) =>
          CupertinoPage<void>(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => EditUserProfileCubit(),
                ),

                BlocProvider(
                  create: (context) => ImagePickerCubit(),
                ),


              ],
              child: EditProfileView(),
            ),
          ),
    ),


  ],
);