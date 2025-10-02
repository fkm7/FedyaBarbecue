import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/category.dart';
import 'package:fedya_shashlik/ui/pages/category/category.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(category: category))),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 140.0,
        width: double.infinity,
        decoration: BoxDecoration(
          border: category.image != null ? null : Border.all(color: Colors.white, width: 0.7),
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: category.image != null ? CachedNetworkImageProvider(category.image!) : Image.asset('assets/error.png').image,
            fit: category.image != null ? BoxFit.cover : BoxFit.contain,
          ),
        ),
        child: Text(
          category.title,
          style: AppTextStyles.categoryName,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
