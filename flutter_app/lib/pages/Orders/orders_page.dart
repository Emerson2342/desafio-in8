import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Orders/widgets/order_item_widget.dart';
import 'package:flutter_app/services/product_service.dart';
import 'package:flutter_app/services/service_locator.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsService = getIt<ProductService>();

    return FutureBuilder(
        future: productsService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao buscar os produtos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado"));
          }
          final orders = snapshot.data!;

          return ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderItemWidget(
                  order: order,
                );
              });
        });
  }
}
