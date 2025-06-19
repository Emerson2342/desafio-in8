import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/string_formatter.dart';
import 'package:flutter_app/models/cart.dart';
import 'package:flutter_app/pages/Orders/widgets/order_items_details_widget.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;

  const OrderItemWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatDate(order.createdAt),
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text("Nome: ${order.name}"),
            Text("Email: ${order.email}"),
            Text("Quantidade de itens: ${order.quantity}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ${priceBr(order.total)}"),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => OrderItemsBottomSheet(order: order),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                  ),
                  child: const Text('Ver mais'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
