import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductWidgetInCategoryPage extends StatelessWidget {
  ProductWidgetInCategoryPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);
    return Container(
      // constraints: BoxConstraints(),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      height: 220.0,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140.0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(0.0, 0.0),
                  color: Colors.white,
                  spreadRadius: 1.0,
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: product.productPhotoObj.isEmpty
                ? Image.asset(
                    'assets/error.png',
                    fit: BoxFit.contain,
                    height: 140.0,
                    width: double.infinity,
                  )
                : CachedNetworkImage(
                    imageUrl: product.productPhotoObj.first.photo ?? '',
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),

                    // progressIndicatorBuilder: (context, string, downPercent) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset('assets/error.png'),
                    fit: product.productPhotoObj.first.photo != null ? BoxFit.cover : BoxFit.contain,
                    height: 140.0,
                    width: double.infinity,
                    imageBuilder: product.count <= 0.0
                        ? (context, provider) => Stack(
                              clipBehavior: Clip.hardEdge,
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image(
                                  image: provider,
                                  height: 140.0,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 140.0,
                                  width: double.infinity,
                                  color: Colors.black45,
                                  child: Text(
                                    'Недоступно',
                                    style: AppTextStyles.title1.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                        : null,
                  ),
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: FittedBox(
                  child: Text(
                    product.title,
                    style: AppTextStyles.title0,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    formatCurrency.format(product.price),
                    style: AppTextStyles.label,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
