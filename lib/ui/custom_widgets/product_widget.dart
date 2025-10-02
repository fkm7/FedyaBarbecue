import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/ui/custom_widgets/add_cart_dialog.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({Key? key, required this.product}) : super(key: key);

  final Product product;
  final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: product.count > 0.0
          ? () => showModalBottomSheet(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                context: context,
                builder: (context) => AddCartDialog(product: product),
              )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              height: 72.0,
              width: 72.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: product.productPhotoObj.isNotEmpty ? product.productPhotoObj.first.photo ?? '' : '',
                  fit: BoxFit.cover,
                  // height: 72.0,
                  // width: 72.0,
                  errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  imageBuilder: product.count <= 0.0
                      ? (context, provider) => Stack(
                            clipBehavior: Clip.hardEdge,
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image(
                                image: provider,
                                height: 72.0,
                                width: 72.0,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 72.0,
                                width: 72.0,
                                color: Colors.black45,
                                child: Text('Недоступно',
                                    style: AppTextStyles.label.copyWith(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          )
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: AppTextStyles.title0,
                ),
                const SizedBox(height: 6.0),
                Text(
                  formatCurrency.format(product.price),
                  style: AppTextStyles.title0,
                ),
                const SizedBox(height: 4.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
