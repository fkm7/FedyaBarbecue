import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/data/model/cart_product.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@immutable
class CartProductWidget extends StatelessWidget {
  final CartProduct cartProduct;

  const CartProductWidget({Key? key, required this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: CachedNetworkImage(
                imageUrl: cartProduct.product.productPhotoObj.first.photo ?? '',
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                height: 96.0,
                width: 96.0,
              ),
            ),
            IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mediaQuery.size.width * .665,
                    child: Text(
                      cartProduct.product.title,
                      style: AppTextStyles.title0,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatCurrency.format(cartProduct.product.price),
                        style: AppTextStyles.title0,
                      ),
                      // const SizedBox(width: 96.0),
                      Container(
                        color: AppColors.dark,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (cartProduct.amount > 1) {
                                  Provider.of<Cart>(context, listen: false).decreaseAmount(cartProduct);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(context)!.removeProduct,
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
                                            Provider.of<Cart>(context, listen: false).decreaseAmount(cartProduct);
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
                                  );
                                }
                              },
                            ),
                            Text(
                              cartProduct.amount.toString(),
                              style: AppTextStyles.title0,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => Provider.of<Cart>(context, listen: false).increaseAmount(cartProduct),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
