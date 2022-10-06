import 'package:fedya_shashlik/bloc/cart.dart';
import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/ui/pages/main/main_page.dart';
import 'package:fedya_shashlik/ui/pages/order/location_picker.dart';
import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartOrderPage extends StatefulWidget {
  const CartOrderPage({Key? key, required this.cart}) : super(key: key);

  static const route = '/cartOrder';

  final Cart cart;

  @override
  _CartOrderPageState createState() => _CartOrderPageState();
}

class _CartOrderPageState extends State<CartOrderPage> {
  String location = '';
  String comment = '';
  final fCur = NumberFormat.currency(name: 'сум', locale: 'uz_UZ', decimalDigits: 0);

  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.makeOrder)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: SizedBox(
                height: mediaQuery.size.height * .15,
                width: mediaQuery.size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                            child: Text(
                              AppLocalizations.of(context)!.address,
                              style: AppTextStyles.label,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          SizedBox(
                            width: mediaQuery.size.width * .65,
                            child: Text(
                              location == '' ? 'Адрес не указан' : location,
                              style: AppTextStyles.label,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.location_on_outlined,
                          size: 32.0,
                        ),
                        onPressed: () async {
                          List<String> addressList =
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationPicker()));
                          location = addressList[1];
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  // ListTile(
                  //   onTap: () {
                  //     showCupertinoModalPopup(
                  //         context: context,
                  //         builder: (context) {
                  //           return CupertinoD;
                  //         });
                  //   },
                  //   leading: const Icon(Icons.access_time),
                  //   title: Text(AppLocalizations.of(context)!.deliveryTime),
                  //   trailing: Text(AppLocalizations.of(context)!.soon),
                  // ),
                  // ListTile(
                  //   onTap: () => showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) => Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //       height: 150,
                  //       child: Column(
                  //         children: [
                  //           ListTile(
                  //             onTap: () => Navigator.pop(context),
                  //             leading: const Icon(Icons.money),
                  //             title: Text(AppLocalizations.of(context)!.cash),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   leading: const Icon(LineIcons.moneyBill),
                  //   title: Text(AppLocalizations.of(context)!.payment),
                  //   trailing: Text(AppLocalizations.of(context)!.cash),
                  // ),
                  ListTile(
                    onTap: () {
                      _commentController.text = comment;
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              height: mediaQuery.size.height * .35,
                              width: mediaQuery.size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.addComment,
                                      style: AppTextStyles.title0,
                                    ),
                                  ),
                                  TextField(
                                    maxLines: 5,
                                    controller: _commentController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                    height: mediaQuery.size.height * .06,
                                    minWidth: mediaQuery.size.width,
                                    color: AppColors.orange,
                                    child: Text(AppLocalizations.of(context)!.send),
                                    onPressed: () {
                                      comment = _commentController.text;
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    leading: const Icon(Icons.comment),
                    title: Text(AppLocalizations.of(context)!.addComment),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        AppLocalizations.of(context)!.order,
                        style: AppTextStyles.label,
                      ),
                      Text(
                        fCur.format(widget.cart.total),
                        style: AppTextStyles.label,
                      ),
                    ]),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.delivery,
                          style: AppTextStyles.label,
                        ),
                        Text(
                          '8 000 сум',
                          style: AppTextStyles.label,
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.total,
                          style: AppTextStyles.title1,
                        ),
                        Text(
                          fCur.format(widget.cart.total + 8000),
                          style: AppTextStyles.title1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(32.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                // splashColor: AppColors.orange,
                color: AppColors.orange,
                height: mediaQuery.size.height * .07,
                minWidth: mediaQuery.size.width,
                child: Text(
                  AppLocalizations.of(context)!.checkout,
                  style: AppTextStyles.title0,
                ),
                onPressed: () async {
                  var statusCode = 0;
                  if (location.isNotEmpty) {
                    statusCode = await ApiService.getInstance().sendOrder(
                      products: widget.cart.products,
                      total: widget.cart.total,
                      address: location,
                    );
                    if (statusCode == 200) {
                      Provider.of<Cart>(context, listen: false).clear();
                      Provider.of<MainPageState>(context, listen: false).changeIndex(0);
                    }
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: SizedBox(
                          height: mediaQuery.size.height * .3,
                          width: mediaQuery.size.width * .9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: statusCode == 200
                                ? [
                                    Image.asset(
                                      'assets/done.png',
                                      height: 72.0,
                                      width: 72.0,
                                    ),
                                    const SizedBox(height: 24.0),
                                    Text(
                                      'Ваш заказ успешно принять',
                                      style: AppTextStyles.title0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ]
                                : [
                                    Image.asset(
                                      'assets/error.png',
                                      height: 72.0,
                                      width: 72.0,
                                    ),
                                    const SizedBox(height: 24.0),
                                    Text(
                                      'Ваш заказ не был принять повторите ещё раз',
                                      style: AppTextStyles.title0,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                          ),
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Выберите адрес доставки',
                        style: AppTextStyles.title0.copyWith(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
