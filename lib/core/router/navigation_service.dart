// part of 'router.dart';
//
//
//
// final navigationServiceProvider = ChangeNotifierProvider( (ref) => NavigationService());
//
// class NavigationService extends ChangeNotifier {
//   String? _redirection;
//
//   void go(String route) {
//     _redirection = route;
//     notifyListeners();
//   }
//
//   String? _consumeRedirection() {
//     if (_redirection != null) {
//       final route = _redirection;
//       _redirection = null;
//       return route;
//     }
//     return null;
//   }
// }
//
// final rootNavigatorKey = GlobalKey<NavigatorState>();
//
// final _routerProvider = Provider(
//   (ref) {
//     final redirectionService = ref.watch(navigationServiceProvider);
//     final redirection = redirectionService._consumeRedirection();
//     return GoRouter(
//       initialLocation: redirection ?? AppRoutes.splashScreen,
//       navigatorKey: rootNavigatorKey,
//       refreshListenable: redirectionService,
//       routes: routes,
//     );
//   },
// );
