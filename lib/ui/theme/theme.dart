import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTextStyles.appBarTitle,
    color: AppColors.dark,
    backgroundColor: AppColors.dark,
  );
}
