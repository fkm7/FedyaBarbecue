import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedya_shashlik/data/model/order.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatelessWidget {
  OrderDetailPage({Key? key, required this.order}) : super(key: key);

  static const route = '/orderDetail';

  final Order order;
  final fCurrency =
      NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заказ №${order.id}'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              itemCount: order.orderItemObj!.length,
              itemBuilder: (context, index) =>
                  OrderItemView(orderItemObj: order.orderItemObj![index]),
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Общая сумма:',
                    style: AppTextStyles.title0,
                  ),
                  Text(
                    fCurrency.format(order.total),
                    style: AppTextStyles.title0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItemView extends StatelessWidget {
  OrderItemView({Key? key, required this.orderItemObj}) : super(key: key);

  final OrderItemObj orderItemObj;
  final fCurrency =
      NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          SizedBox(
            height: 72.0,
            width: 72.0,
            child: CachedNetworkImage(
              imageUrl: orderItemObj.productObj!.productPhotoObj!.first.photo!,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              fit: BoxFit.cover,
              height: 72.0,
              width: 72.0,
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderItemObj.productObj!.title!,
                style: AppTextStyles.title0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .69,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Цена: ${fCurrency.format(orderItemObj.price)}',
                      style: AppTextStyles.label,
                    ),
                    Text(
                      'Кол-во: ${orderItemObj.count!.toInt()}',
                      style: AppTextStyles.label,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
