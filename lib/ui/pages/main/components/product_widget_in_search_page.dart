import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductWidgetInSearchPage extends StatelessWidget {
  ProductWidgetInSearchPage({Key? key, required this.product}) : super(key: key);

  final Product product;
  final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      height: 140,
      width: 175,
      child: Card(
        elevation: 3.0,
        color: AppColors.darkish,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: product.productPhotoObj.isEmpty
                  ? (product.count <= 0.0
                      ? Stack(
                          clipBehavior: Clip.hardEdge,
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image.asset(
                              'assets/error.png',
                              height: 160.0,
                              width: 175.0,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 160.0,
                              width: 175.0,
                              color: Colors.black45,
                              child: Text('Недоступно', style: AppTextStyles.title0.copyWith(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )
                      : Image.asset(
                          'assets/error.png',
                          height: 160.0,
                          width: 175.0,
                          fit: BoxFit.cover,
                        ))
                  : CachedNetworkImage(
                      imageUrl: product.productPhotoObj.first.photo ?? '',
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                      height: 160.0,
                      width: 175.0,
                      fit: product.productPhotoObj.first.photo != null ? BoxFit.cover : BoxFit.contain,
                      imageBuilder: product.count <= 0.0
                          ? (context, provider) => Stack(
                                clipBehavior: Clip.hardEdge,
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image(
                                    image: provider,
                                    height: 160,
                                    width: 175,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 160,
                                    width: 175,
                                    color: Colors.black45,
                                    child: Text('Недоступно', style: AppTextStyles.title0.copyWith(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              )
                          : null,
                    ),
            ),
            const SizedBox(height: 8.0),
            Text(
              product.title,
              style: AppTextStyles.title1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(formatCurrency.format(product.price), style: AppTextStyles.title0),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
