import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
import 'package:fedya_shashlik/ui/pages/profile/order_history.dart';
import 'package:fedya_shashlik/ui/pages/profile/profile.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  static const route = '/account';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[200]!,
                      Colors.transparent,
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/splash.jpg',
                  fit: BoxFit.cover,
                  height: mediaQuery.size.height * .3,
                  width: mediaQuery.size.width,
                ),
              ),
            ],
          ),
          ListTile(
            onTap: () => context.push(ProfilePage.route),
            leading: const Icon(Icons.account_circle_sharp),
            title: Text(AppLocalizations.of(context)!.profile),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => context.push(ProfilePage.route),
            ),
          ),
          const Divider(color: AppColors.grey, height: 2.0),
          ListTile(
            onTap: () async {
              if (await canLaunch('tel:+998906024795')) {
                await launch('tel:+998906024795');
              }
            },
            leading: const Icon(Icons.feedback),
            title: Text(AppLocalizations.of(context)!.feedback),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await canLaunch('tel:+998906024795')) {
                  await launch('tel:+998906024795');
                }
              },
            ),
          ),
          const Divider(color: AppColors.grey, height: 2.0),
          ListTile(
            onTap: () => context.push(OrderHistory.route),
            leading: const Icon(Icons.history),
            title: Text(AppLocalizations.of(context)!.orderHistory),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => context.push(OrderHistory.route),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                height: 60,
                minWidth: mediaQuery.size.width,
                color: AppColors.orange,
                child: Text(
                  AppLocalizations.of(context)!.exit,
                  style: AppTextStyles.title0,
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.exitFromApp),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          UserPreferences.getInstance().logOut();
                          Provider.of<MainPageState>(context, listen: false).changeIndex(0);
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.yes),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context)!.no),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
