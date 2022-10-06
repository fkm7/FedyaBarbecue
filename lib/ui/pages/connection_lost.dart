import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionLostPage extends StatelessWidget {
  const ConnectionLostPage({Key? key}) : super(key: key);

  static const route = '/lost';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_connection.png',
            height: 256,
            width: 256,
          ),
          const SizedBox(height: 24.0),
          Align(
            child: Text(
              AppLocalizations.of(context)!.connectionLost,
              style: AppTextStyles.title0,
            ),
          ),
        ],
      ),
    );
  }
}
