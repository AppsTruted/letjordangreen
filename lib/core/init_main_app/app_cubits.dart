//
// import 'package:mutah/features/feature_all_products/rate_us_cubit/all_products_cubit/all_products_cubit.dart';
// import 'package:mutah/features/feature_categories/rate_us_cubit/my_cards_cubit/my_cards_cubit/translations_by_restaurant_id_cubit.dart';
// import 'package:mutah/features/feature_featured_products/rate_us_cubit/featured_products_cubit/featured_products_cubit.dart';
// import 'package:mutah/features/feature_home_page/rate_us_cubit/get_banners_cubit/banners_cubit.dart';
// import 'package:mutah/features/feature_home_page/rate_us_cubit/products_categories_cubit/products_categories_cubit.dart';
// import 'package:mutah/features/feature_search/cubit/search_cubit.dart';
//
// class AppCubits {
//   final SearchCubit searchCubit;
//   final CategoriesCubit categoriesCubit;
//   final AllProductsCubit allProductsCubit;
//   final ProductsCategoriesCubit productsCategoriesCubit;
//   final FeaturedProductsCubit featuredProductsCubit;
//
//   final BannersCubit bannersCubit;
//   AppCubits({
//     required this.searchCubit,
//     required this.categoriesCubit,
//     required this.allProductsCubit,
//     required this.productsCategoriesCubit,
//     required this.bannersCubit,
//     required this.featuredProductsCubit
//   });
//
//   static Future<AppCubits> initialize() async {
//     final searchCubit = SearchCubit();
//     final categoriesCubit = CategoriesCubit();
//
//     final allProductsCubit = AllProductsCubit();
//     final bannersCubit = BannersCubit();
//
//     final productsCategoriesCubit = ProductsCategoriesCubit();
//    //
//    final featuredProductsCubit = FeaturedProductsCubit();
//
//     await Future.wait([
//       searchCubit.fetchAllProducts(query: ''),
//       categoriesCubit.getCategories().then((onValue) {
//         if (onValue.isNotEmpty) {
//           productsCategoriesCubit.searchProducts("", categoryId: onValue.first.id);
//         } else {
//           productsCategoriesCubit.searchProducts("");
//         }
//       }),
//
//       allProductsCubit.fetchAllProducts(""),
//       bannersCubit.getBanners(),
//       featuredProductsCubit.getFeaturedProducts()
//     ]);
//
//     return AppCubits(
//       searchCubit: searchCubit,
//       categoriesCubit: categoriesCubit,
//       allProductsCubit: allProductsCubit,
//       bannersCubit : bannersCubit,
//         featuredProductsCubit : featuredProductsCubit,
//         productsCategoriesCubit: productsCategoriesCubit
//     );
//   }
// }
