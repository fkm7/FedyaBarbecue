// import 'package:fedya_shashlik/app_state.dart';
// import 'package:fedya_shashlik/ui/pages/category/categories.dart';
// import 'package:fedya_shashlik/ui/pages/category/category.dart';
// import 'package:fedya_shashlik/ui/pages/connection_lost.dart';
// import 'package:fedya_shashlik/ui/pages/main/cart/location_picker.dart';
// import 'package:fedya_shashlik/ui/pages/entry/splash.dart';
// import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
// import 'package:fedya_shashlik/ui/pages/main/products.dart';
// import 'package:fedya_shashlik/ui/pages/main/search.dart';
// import 'package:flutter/foundation.dart';
//
// const String SplashPath = SplashPage.route;
// const String MainPagePath = MainPage.route;
// const String SearchPagePath = SearchPage.route;
// const String CategoriesPath = CategoriesPage.route;
// const String CategoryPath = CategoryPage.route;
// const String ProductsPath = ProductsPage.route;
// const String ConnectionLostPath = ConnectionLostPage.route;
// const String
//
// enum Pages { Splash, Login, CreateAccount, List, Details, Cart, Checkout, Settings }
//
// class PageConfiguration {
//   final String key;
//   final String path;
//   final Pages uiPage;
//   PageAction? currentPageAction;
//
//   PageConfiguration({
//     required this.key,
//     required this.path,
//     required this.uiPage,
//     this.currentPageAction,
//   });
// }
//
// PageConfiguration SplashPageConfig = PageConfiguration(
//   key: 'Splash',
//   path: SplashPath,
//   uiPage: Pages.Splash,
//   currentPageAction: null,
// );
// PageConfiguration LoginPageConfig = PageConfiguration(
//   key: 'Login',
//   path: LoginPath,
//   uiPage: Pages.Login,
//   currentPageAction: null,
// );
// PageConfiguration CreateAccountPageConfig = PageConfiguration(
//   key: 'CreateAccount',
//   path: CreateAccountPath,
//   uiPage: Pages.CreateAccount,
//   currentPageAction: null,
// );
// PageConfiguration ListItemsPageConfig = PageConfiguration(key: 'ListItems', path: ListItemsPath, uiPage: Pages.List);
// PageConfiguration DetailsPageConfig = PageConfiguration(
//   key: 'Details',
//   path: DetailsPath,
//   uiPage: Pages.Details,
//   currentPageAction: null,
// );
// PageConfiguration CartPageConfig = PageConfiguration(key: 'Cart', path: CartPath, uiPage: Pages.Cart, currentPageAction: null);
// PageConfiguration CheckoutPageConfig = PageConfiguration(
//   key: 'Checkout',
//   path: CheckoutPath,
//   uiPage: Pages.Checkout,
//   currentPageAction: null,
// );
// PageConfiguration SettingsPageConfig = PageConfiguration(
//   key: 'Settings',
//   path: SettingsPath,
//   uiPage: Pages.Settings,
//   currentPageAction: null,
// );
