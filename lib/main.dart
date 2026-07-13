import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:letjordangreen/features/feature_auth/feature_check_token/cubit/check_token_cubit.dart';
import 'package:letjordangreen/features/feature_drawer_initialize/presentation/cubits/page_view_provider.dart';
import 'package:letjordangreen/features/feature_farmer_supply_orders/cubits/farmer_supply_orders_cubit.dart';
import 'package:letjordangreen/features/feature_inspection_queue/cubits/inspection_queue_cubit.dart';
import 'package:letjordangreen/features/feature_map/cubit/public_map_cubit.dart';
import 'package:letjordangreen/features/feature_profile/cubits/profile_cubits/profile_cubit.dart';
import 'package:letjordangreen/features/feature_projects/cubits/projects_cubit.dart';
import 'package:letjordangreen/features/feature_scan_qr/cubits/scan_qr_cubit/scan_qr_cubit.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:provider/provider.dart';
import 'core/hive/user.dart';
import 'core/router/routes.dart';
import 'core/utils/constants/app_theme.dart';
import 'translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('en_US', null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveModelAdapter());
  Hive.openBox<UserHiveModel>('userBox');
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageViewProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CheckTokenCubit()..getCheckToken(context),
          ),
          BlocProvider(create: (context) => UserInformationCubit(),),
          BlocProvider(create: (context) => ProjectsCubit()..getProjects(),),
          BlocProvider(create: (context) => ScanQrCubit(),),
          BlocProvider(create: (context) => PublicMapCubit()..getTreesOnMap(),),
          BlocProvider(
            create: (context) => ProfileCubit()..getUserProfile(),
          ),
          BlocProvider(
            create: (context) => InspectionQueueCubit()..getRestaurantOrders(),
          ),
          BlocProvider(
            create: (context) => FarmerSupplyOrdersCubit()..getMyOrders(),
          ),


        ],
        child: MaterialApp.router(
          title: 'Let Jo Green',
          debugShowCheckedModeBanner: false,
          theme: enTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: router,
          builder: (context, child) {
            return Material(
              child: child,
            );
          },
        ),
      ),
    );
  }
}
