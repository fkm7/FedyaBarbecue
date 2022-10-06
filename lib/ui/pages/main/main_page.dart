import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/ui/pages/auth/authentication.dart';
import 'package:fedya_shashlik/ui/pages/main/home.dart';
import 'package:fedya_shashlik/ui/pages/main/search.dart';
import 'package:fedya_shashlik/ui/pages/order/cart.dart';
import 'package:fedya_shashlik/ui/pages/profile/account.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const route = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class MainPageState extends ChangeNotifier {
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void changeIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _children = [
     HomePage(),
     SearchPage(),
     CartPage(pageInMain: true),
     AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: IndexedStack(
        index: context.watch<MainPageState>().pageIndex,
        children: _children,
        // switchInCurve: Curves.easeIn,
        // switchOutCurve: Curves.easeInOut,
        // duration: const Duration(milliseconds: 500),
        // child: _children[context.watch<MainPageState>().pageIndex],
      ),
      // bottomNavigationBar: buildMyNavBar(context),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: context.watch<MainPageState>().pageIndex,
        onTap: (currentIndex) async {
          var auth = (await UserPreferences.getInstance().getToken()) != null;
          if (currentIndex > 1 && !auth) {
            context.push(AuthPage.route);
          } else {
            context.read<MainPageState>().changeIndex(currentIndex);
          }
        },
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.home,
            activeIcon: const Icon(
              Icons.home_sharp,
              color: AppColors.orange,
              size: 35,
            ),
            icon: const Icon(
              Icons.home_outlined,
              color: AppColors.orange,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.search,
            activeIcon: const Icon(
              Icons.search,
              color: AppColors.orange,
              size: 35,
            ),
            icon: const Icon(
              Icons.search,
              color: AppColors.orange,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.cart,
            activeIcon: const Icon(
              Icons.shopping_cart,
              color: AppColors.orange,
              size: 35,
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.orange,
              size: 35,
            ),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.account,
            activeIcon: const Icon(
              Icons.person,
              color: AppColors.orange,
              size: 35,
            ),
            icon: const Icon(
              Icons.person_outline,
              color: AppColors.orange,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

// Widget buildMyNavBar(BuildContext context) {
//   return Container(
//     height: 60,
//     decoration: BoxDecoration(
//       color: Theme.of(context).primaryColor,
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(20),
//         topRight: Radius.circular(20),
//       ),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         IconButton(
//           enableFeedback: false,
//           onPressed: () => setState(() => pageIndex = 0),
//           icon: pageIndex == 0
//               ? const Icon(
//                   Icons.home_filled,
//                   color: AppColors.orange,
//                   size: 35,
//                 )
//               : const Icon(
//                   Icons.home_outlined,
//                   color: AppColors.orange,
//                   size: 35,
//                 ),
//         ),
//         IconButton(
//           enableFeedback: false,
//           onPressed: () async {
//             var auth = (await UserPreferences.getInstance().getToken()) != null;
//             if (!auth) {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
//             } else {
//               setState(() => pageIndex = 1);
//             }
//           },
//           icon: pageIndex == 1
//               ? const Icon(
//                   Icons.shopping_cart,
//                   color: AppColors.orange,
//                   size: 35,
//                 )
//               : const Icon(
//                   Icons.shopping_cart_outlined,
//                   color: AppColors.orange,
//                   size: 35,
//                 ),
//         ),
//         // IconButton(
//         //   enableFeedback: false,
//         //   onPressed: () => setState(() => pageIndex = 2),
//         //   icon: pageIndex == 2
//         //       ? const Icon(
//         //           Icons.widgets_rounded,
//         //           color: Colors.white,
//         //           size: 35,
//         //         )
//         //       : const Icon(
//         //           Icons.widgets_outlined,
//         //           color: Colors.white,
//         //           size: 35,
//         //         ),
//         // ),
//         IconButton(
//           enableFeedback: false,
//           onPressed: () async {
//             var auth = (await UserPreferences.getInstance().getToken()) != null;
//             if (!auth) {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
//             } else {
//               setState(() => pageIndex = 2);
//             }
//           },
//           icon: pageIndex == 2
//               ? const Icon(
//                   Icons.person,
//                   color: AppColors.orange,
//                   size: 35,
//                 )
//               : const Icon(
//                   Icons.person_outline,
//                   color: AppColors.orange,
//                   size: 35,
//                 ),
//         ),
//       ],
//     ),
//   );
// }
}
