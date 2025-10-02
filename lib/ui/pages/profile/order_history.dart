import 'package:fedya_shashlik/data/model/order.dart';
import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:fedya_shashlik/ui/pages/profile/order_detail.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  static const route = '/orderHistory';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.orderHistory)),
      body: FutureBuilder(
        future: ApiService.getInstance().getOrdersByUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16.0),
                    Text(
                      'Подождите идёт загрузка ваших заказов',
                      style: AppTextStyles.label,
                    ),
                  ],
                ),
              );
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                OrderResponse response = snapshot.data as OrderResponse;
                return response.results!.isEmpty
                    ? Center(
                        child: Image.asset(
                        'assets/not_found.png',
                        height: 256,
                        width: 256,
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        itemCount: response.results!.length,
                        itemBuilder: (context, index) => OrderCard(order: response.results![response.results!.length - index - 1]),
                      );
              }
              break;
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/not_found.png',
                  height: 256,
                  width: 256,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Вы ещё не заказывали!',
                  style: AppTextStyles.title0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(locale: 'uz_UZ', name: 'сум', decimalDigits: 0);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailPage(order: order))),
      child: Container(
        height: 210,
        width: 400,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '№:${order.id}',
                  style: AppTextStyles.title0,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${AppLocalizations.of(context)!.applicationTime}: ${order.created!.hour}:${order.created!.minute < 10 ? '0${order.created!.minute}' : order.created!.minute}  ${order.created!.day < 10 ? '0${order.created!.day}' : order.created!.day}.${order.created!.month < 10 ? '0${order.created!.month}' : order.created!.month}.${order.created!.year}',
                  style: AppTextStyles.title0,
                ),
                const SizedBox(height: 4.0),
                Text('${AppLocalizations.of(context)!.applicationStatus}: ${order.status}', style: AppTextStyles.title0),
                const SizedBox(height: 4.0),
                Text(
                  "${AppLocalizations.of(context)!.sum}: ${formatCurrency.format(order.total)}",
                  style: AppTextStyles.title0,
                ),
                const SizedBox(height: 4.0),
                SizedBox(
                  width: 400,
                  child: Text(
                    "${AppLocalizations.of(context)!.address}: ${order.customerAddress!}",
                    style: AppTextStyles.title0,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
