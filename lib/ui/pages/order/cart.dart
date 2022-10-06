import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/ui/pages/order/cart_product_widget.dart';
import 'package:fedya_shashlik/ui/pages/order/cart_order_page.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartPage extends StatefulWidget {
   CartPage({Key? key, required this.pageInMain}) : super(key: key);

  static const route = '/order';

  final bool pageInMain;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Consumer<Cart>(
      builder: (context, cart, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.cart,
            style: AppTextStyles.appBarTitle,
          ),
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.trashAlt),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.cleanCart,
                    style: AppTextStyles.label,
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: AppTextStyles.label.copyWith(color: Colors.red),
                      ),
                      onPressed: () {
                        setState(() => cart.clear());
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: AppTextStyles.label,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Divider(height: 1.0, thickness: 0.5, color: AppColors.grey),
            Container(
              height: widget.pageInMain ? mediaQuery.size.height * .57 : mediaQuery.size.height * .63,
              width: mediaQuery.size.width,
              padding: const EdgeInsets.symmetric(vertical: 24),
              color: AppColors.darkish,
              child: cart.products.isNotEmpty
                  ? ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (context, index) => CartProductWidget(cartProduct: cart.products.elementAt(index)),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/box.png',
                          height: 128.0,
                          width: 128.0,
                          fit: BoxFit.fill,
                        ),
                        Text(AppLocalizations.of(context)!.cartEmpty),
                      ],
                    ),
            ),
            Expanded(
              child: Container(
                alignment: FractionalOffset.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.total,
                      style: AppTextStyles.title0,
                    ),
                    Text(
                      formatCurrency.format(cart.total),
                      style: AppTextStyles.title0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            disabledColor: Colors.grey,
            height: mediaQuery.size.height * .075,
            minWidth: mediaQuery.size.width,
            color: AppColors.orange,
            onPressed: cart.products.isNotEmpty
                ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartOrderPage(cart: cart)))
                : null,
            child: Text(
              AppLocalizations.of(context)!.makeOrder,
              style: AppTextStyles.title0,
            ),
          ),
        ),
      ),
    );
  }
}
