import 'dart:async';

import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  static const route = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => context.go(MainPage.route));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Image.asset(
        'assets/fedya.jpg',
        fit: BoxFit.cover,
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
      ),
    );
  }
}
