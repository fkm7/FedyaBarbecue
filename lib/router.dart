import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/bloc/connection/connection_cubit.dart';
import 'package:fedya_shashlik/data/model/category.dart';
import 'package:fedya_shashlik/ui/pages/auth/authentication.dart';
import 'package:fedya_shashlik/ui/pages/category/categories.dart';
import 'package:fedya_shashlik/ui/pages/category/category.dart';
import 'package:fedya_shashlik/ui/pages/connection_lost.dart';
import 'package:fedya_shashlik/ui/pages/entry/splash.dart';
import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
import 'package:fedya_shashlik/ui/pages/main/products.dart';
import 'package:fedya_shashlik/ui/pages/main/search.dart';
import 'package:fedya_shashlik/ui/pages/order/cart.dart';
import 'package:fedya_shashlik/ui/pages/order/cart_order_page.dart';
import 'package:fedya_shashlik/ui/pages/order/location_picker.dart';
import 'package:fedya_shashlik/ui/pages/profile/account.dart';
import 'package:fedya_shashlik/ui/pages/profile/order_history.dart';
import 'package:fedya_shashlik/ui/pages/profile/profile.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  final ConnectionCheckerCubit checkerCubit;

  MyRouter(this.checkerCubit);

  late final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(checkerCubit.stream),
    redirect: (GoRouterState state) {
      final stateOfConnection = checkerCubit.state;
      final currentLocation = state.location;
      if (stateOfConnection is InternetConnectionDisconnected && currentLocation != ConnectionLostPage.route) {
        return ConnectionLostPage.route;
      }
      if (stateOfConnection is InternetConnectionConnected && currentLocation == ConnectionLostPage.route) {
        return MainPage.route;
      }
      return null;
    },
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: SplashPage.route,
        builder: (context, state) =>  SplashPage(),
      ),
      GoRoute(
        path: MainPage.route,
        builder: (context, state) =>  MainPage(),
      ),
      GoRoute(
        path: CategoriesPage.route,
        builder: (context, state) =>  CategoriesPage(),
      ),
      GoRoute(
        path: CategoryPage.route,
        builder: (context, state) => CategoryPage(category: state.extra as Category),
      ),
      GoRoute(
        path: SearchPage.route,
        builder: (context, state) => SearchPage(),
      ),
      GoRoute(
        path: ProductsPage.route,
        builder: (context, state) =>  ProductsPage(),
      ),
      GoRoute(
        path: CartPage.route,
        builder: (context, state) => CartPage(pageInMain: state.extra as bool),
      ),
      GoRoute(
        path: CartOrderPage.route,
        builder: (context, state) => CartOrderPage(cart: state.extra as Cart),
      ),
      GoRoute(
        path: LocationPicker.route,
        builder: (context, state) =>  LocationPicker(),
      ),
      GoRoute(
        path: AccountPage.route,
        builder: (context, state) => AccountPage(),
      ),
      GoRoute(
        path: AuthPage.route,
        builder: (context, state) =>  AuthPage(),
      ),
      GoRoute(
        path: ProfilePage.route,
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: OrderHistory.route,
        builder: (context, state) => OrderHistory(),
      ),
      GoRoute(
        path: ConnectionLostPage.route,
        builder: (context, state) =>  ConnectionLostPage(),
      ),
    ],
    restorationScopeId: 'app',
  );
}
