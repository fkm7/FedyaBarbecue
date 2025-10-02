// import 'package:fedya_shashlik/ui/pages/category/categories.dart';
// import 'package:fedya_shashlik/ui/pages/connection_lost.dart';
// import 'package:fedya_shashlik/ui/pages/main/cart/location_picker.dart';
// import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
// import 'package:fedya_shashlik/ui/pages/main/products.dart';
// import 'package:fedya_shashlik/ui/pages/main/search.dart';
// import 'package:flutter/material.dart';
//
// class Routes {
//   static final namedRoutes = <String, WidgetBuilder>{
//     MainPage.route: (context) => const MainPage(),
//     SearchPage.route: (context) => const SearchPage(),
//     CategoriesPage.route: (context) => const CategoriesPage(),
//     ProductsPage.route: (context) => const ProductsPage(),
//     PickAddressPage.route: (context) => const PickAddressPage(),
//     ConnectionLostPage.route: (context) => const ConnectionLostPage(),
//   };
//
// routes: Routes.namedRoutes,
// onGenerateRoute: (settings) {
//   if (RegistrationPage.route == settings.name) {
//     final args = settings.arguments as String;
//     return MaterialPageRoute(builder: (context) => RegistrationPage(phone: args));
//   }
// if (PickAddressPage.route == settings.name) {
//   final args = settings.arguments as Cart;
//   return MaterialPageRoute(builder:);
// }
// if (DetailPage.route == settings.name) {
//   final args = settings.arguments as Product;
//   return MaterialPageRoute(builder: (context) => DetailPage(product: args));
// }
// if (CategoryPage.route == settings.name) {
//   final args = settings.arguments as Category;
//   return MaterialPageRoute(builder: (context) => CategoryPage(category: args));
// }
// if (HomePage.route == settings.name) {
//   final args = settings.arguments as MediaQueryData;
//   return MaterialPageRoute(builder: (context) => HomePage(mediaQuery: args));
// }
// return MaterialPageRoute(builder: (context) => const SplashPage());
// },
//
// }
