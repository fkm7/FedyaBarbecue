import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fedya_shashlik/bloc/category.dart';
import 'package:fedya_shashlik/bloc/product.dart';
import 'package:fedya_shashlik/data/model/promo.dart';
import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/ui/custom_widgets/product_widget.dart';
import 'package:fedya_shashlik/ui/pages/category/categories.dart';
import 'package:fedya_shashlik/ui/pages/category/category_card_widget.dart';
import 'package:fedya_shashlik/ui/pages/main/products.dart';
import 'package:fedya_shashlik/ui/pages/main/search.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final rxPrefs = RxSharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          StreamBuilder(
            stream: rxPrefs.getStringStream('firstName'),
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                '${AppLocalizations.of(context)!.hello} ${snapshot.data ?? ''}',
                style: AppTextStyles.headline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: GestureDetector(
              onTap: () => context.push(SearchPage.route),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 12.0),
                      Text(
                        AppLocalizations.of(context)!.search,
                        style: AppTextStyles.title0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: ApiService.getInstance().getPromos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Promo> promos = snapshot.data as List<Promo>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        height: mediaQuery.size.height * .25,
                        viewportFraction: 1,
                      ),
                      itemCount: promos.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) =>
                              Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        clipBehavior: Clip.hardEdge,
                        height: mediaQuery.size.height * .25,
                        width: mediaQuery.size.width,
                        child: CachedNetworkImage(
                          imageUrl: promos[index].image == ''
                              ? 'https://picsum.photos/200/300'
                              : promos[index].image,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/error.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  clipBehavior: Clip.hardEdge,
                  height: mediaQuery.size.height * .25,
                  width: mediaQuery.size.width,
                  // alignment: Alignment.center,
                  child: const Card(
                      child: Center(child: CircularProgressIndicator())),
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.categories,
                  style: AppTextStyles.title0,
                ),
                GestureDetector(
                  onTap: () => context.push(CategoriesPage.route),
                  child: Text(
                    AppLocalizations.of(context)!.seeAll,
                    style: AppTextStyles.title0.copyWith(color: AppColors.grey),
                  ),
                ),
              ],
            ),
          ),
          Consumer<CategoryBloc>(
            builder: (context, bloc, child) => SizedBox(
              height: mediaQuery.size.height * .2,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 18),
                itemCount: bloc.categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    CategoryCard(category: bloc.categories[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.popular,
                  style: AppTextStyles.title0,
                ),
                GestureDetector(
                  onTap: () => context.push(ProductsPage.route),
                  child: Text(
                    AppLocalizations.of(context)!.seeAll,
                    style: AppTextStyles.title0.copyWith(color: AppColors.grey),
                  ),
                ),
              ],
            ),
          ),
          Consumer<ProductBloc>(
              builder: (context, bloc, child) => Column(
                  children: bloc.products
                      .take(4)
                      .map((e) => ProductWidget(product: e))
                      .toList())),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
