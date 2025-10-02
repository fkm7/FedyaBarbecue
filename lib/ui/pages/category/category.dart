import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/bloc/product.dart';
import 'package:fedya_shashlik/data/model/category.dart';
import 'package:fedya_shashlik/ui/custom_widgets/add_cart_dialog.dart';
import 'package:fedya_shashlik/ui/pages/category/product_widget_in_category_page.dart';
import 'package:fedya_shashlik/ui/pages/order/cart.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key, required this.category}) : super(key: key);

  static const route = '/category';

  final Category category;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final fCur = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);
    var appBar = AppBar(
      elevation: 3.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: Text(category.title, style: AppTextStyles.appBarTitle),
    );
    return Scaffold(
      appBar: appBar,
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mediaQuery.size.height * .35,
              width: mediaQuery.size.width,
              child: ShaderMask(
                shaderCallback: (Rect bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey[200]!,
                    Colors.transparent,
                  ],
                ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
                blendMode: BlendMode.dstIn,
                child: category.image != null
                    ? CachedNetworkImage(
                        imageUrl: category.image!,
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: mediaQuery.size.width,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                      )
                    : Image.asset(
                        'assets/error.png',
                        fit: BoxFit.cover,
                        height: 100.0,
                        width: mediaQuery.size.width,
                      ),
              ),
            ),
            const SizedBox(height: 24),
            Consumer<ProductBloc>(
              builder: (context, bloc, child) {
                var products = bloc.getByCategory(category.id);
                return SizedBox(
                  height: mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.size.height * .35 -
                      mediaQuery.padding.vertical -
                      mediaQuery.viewPadding.vertical -
                      mediaQuery.viewInsets.vertical,
                  child: GridView.builder(
                    itemCount: products.length,
                    padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: products[index].count > 0.0
                          ? () => showModalBottomSheet(
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                context: context,
                                builder: (context) => AddCartDialog(product: products[index]),
                              )
                          : null,
                      child: ProductWidgetInCategoryPage(product: products[index]),
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        Visibility(
          visible: Provider.of<Cart>(context).products.isNotEmpty,
          child: Positioned(
            left: 0,
            right: 0,
            bottom: 20.0,
            child: GestureDetector(
              onTap: () {
                context.push(CartPage.route, extra: false);
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartPage(pageInMain: false)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height: mediaQuery.size.height * .08,
                width: mediaQuery.size.width,
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.cart,
                      style: AppTextStyles.title0.copyWith(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          Provider.of<Cart>(context, listen: true).amount.toString(),
                          style: AppTextStyles.title0.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 24.0),
                        Text(
                          fCur.format(Provider.of<Cart>(context, listen: true).total),
                          style: AppTextStyles.title0.copyWith(color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
