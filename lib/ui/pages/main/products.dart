import 'package:fedya_shashlik/bloc/product.dart';
import 'package:fedya_shashlik/ui/custom_widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
   ProductsPage({Key? key}) : super(key: key);

  static const route = '/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.products),
      ),
      body: Consumer<ProductBloc>(
        builder: (context, bloc, child) => ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: bloc.products.length,
          itemBuilder: (context, index) => ProductCard(product: bloc.products[index]),
        ),
      ),
    );
  }
}
