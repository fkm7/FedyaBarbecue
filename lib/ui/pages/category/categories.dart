import 'package:fedya_shashlik/bloc/category.dart';
import 'package:fedya_shashlik/ui/pages/category/category_widget.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static const route = '/categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.category,
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: Consumer<CategoryBloc>(
        builder: (context, bloc, child) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          itemCount: bloc.categories.length,
          itemBuilder: (context, index) => CategoryWidget(
            category: bloc.categories[index],
          ),
        ),
      ),
    );
  }
}
