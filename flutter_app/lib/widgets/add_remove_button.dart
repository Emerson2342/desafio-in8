import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/message_helper.dart';
import 'package:flutter_app/models/cart.dart';
import 'package:flutter_app/models/products_model.dart';
import 'package:flutter_app/services/product_service.dart';

ElevatedButton addRemoveCart(
    BuildContext context,
    bool isOnCart,
    CartModel? prodToDelete,
    ProductService productsService,
    IProductModel product,
    String origin) {
  return ElevatedButton.icon(
    onPressed: () async {
      if (isOnCart && prodToDelete != null) {
        await productsService.removeFromCart(prodToDelete.id!);

        if (!context.mounted) {
          return;
        }
        showMessage(context, 'Produto removido do carrinho!');
        Navigator.of(context).pop();
      } else {
        final CartModel cartP = CartModel(
          productId: product.id,
          name: product.nome,
          price: double.parse(product.preco),
          quantity: 1,
          img: "https://picsum.photos/75/75?random=${product.id}",
          origin: origin,
        );
        productsService.addToCart(cartP);
        if (!context.mounted) {
          return;
        }
        showMessage(context, 'Produto adicionado ao carrinho!');

        Navigator.of(context).pop();
      }
    },
    icon: Icon(
      isOnCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
      color: Colors.white,
    ),
    label: Text(isOnCart ? "Remover do Carrinho" : "Adicionar ao Carrinho"),
    style: ElevatedButton.styleFrom(
      backgroundColor: isOnCart ? Colors.red : Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  );
}
