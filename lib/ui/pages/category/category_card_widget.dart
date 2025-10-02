import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/category.dart';
import 'package:fedya_shashlik/ui/pages/category/category.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(CategoryPage.route, extra: category),
      child: Container(
        // decoration: BoxDecoration(
          // borderRadius: category.image != null ? null : BorderRadius.circular(10.0),
          // border: category.image != null ? null : Border.all(color: Colors.white, width: 0.5),
        // ),
        constraints: const BoxConstraints(
          maxHeight: 140.0,
          maxWidth: 140.0,
        ),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: CachedNetworkImage(
                imageUrl: category.image ?? '',
                height: 100.0,
                fit:category.image!=null? BoxFit.cover:BoxFit.contain,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/error.png',
                  // bundle: ,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              category.title,
              style: AppTextStyles.title0.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
