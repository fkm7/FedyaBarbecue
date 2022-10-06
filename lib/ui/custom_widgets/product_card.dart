import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/ui/custom_widgets/add_cart_dialog.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;
  final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: product.count > 0.0
          ? () => showModalBottomSheet(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                context: context,
                builder: (context) => AddCartDialog(product: product),
              )
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        height: mediaQuery.size.height * .3,
        width: mediaQuery.size.width,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: mediaQuery.size.height * .1,
                    maxWidth: mediaQuery.size.width,
                  ),
                  child: product.productPhotoObj.isEmpty
                      ? Image.asset(
                          'assets/error.png',
                          fit: BoxFit.fitHeight,
                        )
                      : CachedNetworkImage(
                          imageUrl: product.productPhotoObj.first.photo ?? '',
                          fit: product.productPhotoObj.first.photo != null ? BoxFit.cover : BoxFit.fitHeight,
                          // height: mediaQuery.size.height * .21,
                          width: mediaQuery.size.width,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                          imageBuilder: product.count <= 0.0
                              ? (context, provider) => Stack(
                                    clipBehavior: Clip.hardEdge,
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Image(
                                        image: provider,
                                        fit: BoxFit.cover,
                                        // height: mediaQuery.size.height * .21,
                                        width: mediaQuery.size.width,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        // height: mediaQuery.size.height * .21,
                                        width: mediaQuery.size.width,
                                        // constraints: BoxConstraints(),
                                        color: Colors.black45,
                                        child: Text(
                                          'Недоступно',
                                          style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )
                              : null),
                ),
              ),
              if (product.productPhotoObj.isEmpty || product.productPhotoObj[0].photo == null)
                const Divider(
                  height: 0.5,
                  color: Colors.white,
                  thickness: 0.5,
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.title,
                      style: AppTextStyles.title1,
                    ),
                    Text(
                      formatCurrency.format(product.price),
                      style: AppTextStyles.title0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
