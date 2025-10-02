import 'package:flutter/material.dart';

class BackButtonDispatcher extends RootBackButtonDispatcher {
  final RouterDelegate _routerDelegate;

  BackButtonDispatcher(this._routerDelegate)
      : super();

  @override
  Future<bool> didPopRoute() {
    return _routerDelegate.popRoute();
  }
}
