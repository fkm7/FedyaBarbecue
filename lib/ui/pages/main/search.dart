import 'package:fedya_shashlik/bloc/product.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/ui/custom_widgets/add_cart_dialog.dart';
import 'package:fedya_shashlik/ui/pages/main/components/product_widget_in_search_page.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  static const route = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';

  var mask = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProductBloc>(
        builder: (context, bloc, child) {
          final List<Product> products = bloc.products;

          bool filter(Product product) {
            return product.title.toLowerCase().contains(searchText.toLowerCase());
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.search,
                    style: AppTextStyles.headline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: AppColors.darkish,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        onChanged: (value) => setState(() => searchText = value),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.brownishOrange,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Text(
                    AppLocalizations.of(context)!.results,
                    style: AppTextStyles.title0,
                  ),
                ),
                Container(
                  height: 300,
                  width: mediaQuery.size.width,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) => filter(products[index])
                        ? GestureDetector(
                            onTap: products[index].count > 0.0
                                ? () => showModalBottomSheet(
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                      context: context,
                                      builder: (context) => AddCartDialog(product: products[index]),
                                    )
                                : null,
                            child: ProductWidgetInSearchPage(product: products[index]),
                          )
                        : Container(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
