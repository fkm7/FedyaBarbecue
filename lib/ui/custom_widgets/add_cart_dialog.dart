import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/data/model/cart_product.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/prefs/user.dart';
import 'package:fedya_shashlik/ui/pages/auth/authentication.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddCartDialog extends StatefulWidget {
  const AddCartDialog({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  _AddCartDialogState createState() => _AddCartDialogState();
}

class _AddCartDialogState extends State<AddCartDialog> {
  int count = 1;
  final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 600,
            child: widget.product.productPhotoObj.isEmpty
                ? Image.asset(
                    'assets/error.png',
                    fit: BoxFit.contain,
                  )
                : CachedNetworkImage(
                    imageUrl: widget.product.productPhotoObj.first.photo ?? '',
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                    height: 200,
                    fit: widget.product.productPhotoObj.first.photo != null ? BoxFit.cover : BoxFit.contain,
                  ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 12, top: 8),
            alignment: Alignment.centerLeft,
            child: Text(widget.product.title, style: AppTextStyles.headline),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(formatCurrency.format(widget.product.price * count), style: AppTextStyles.title0),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (count > 1) {
                          setState(() => count--);
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Text(count.toString(), style: AppTextStyles.title0),
                    IconButton(
                      onPressed: () => setState(() => count++),
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: MaterialButton(
              height: 60,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              color: AppColors.orange,
              onPressed: () async {
                var auth = (await UserPreferences.getInstance().getToken()) != null;
                if (auth) {
                  CartProduct product = CartProduct(
                    product: widget.product,
                    amount: count,
                    total: (count * widget.product.price).toDouble(),
                  );
                  Provider.of<Cart>(context, listen: false).insert(product);
                  Navigator.pop(context);
                } else {
                  context.push(AuthPage.route);
                }
              },
              child: Text(AppLocalizations.of(context)!.addCart, style: AppTextStyles.label),
            ),
          ),
        ],
      ),
    );
  }
}
