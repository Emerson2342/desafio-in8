import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/message_helper.dart';
import 'package:flutter_app/models/cart.dart';
import 'package:flutter_app/pages/Cart/widgets/cart_item_widget.dart';
import 'package:flutter_app/pages/Cart/widgets/purchase_widget.dart';
import 'package:flutter_app/services/product_service.dart';
import 'package:flutter_app/services/service_locator.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final productsService = getIt<ProductService>();
  List<CartModel> productsCart = [];
  List<CartModel> selectedProducts = [];
  late Future<List<CartModel>> _productsCartBuilder;

  @override
  void initState() {
    super.initState();
    _productsCartBuilder = productsService.getCartProducts();
    _loadProductsCart();
  }

  void _loadProductsCart() async {
    final products = await productsService.getCartProducts();
    setState(() {
      productsCart = products;
    });
  }

  void toggleSelection(CartModel product, bool? selected) {
    debugPrint("Selecionado? - ${selected.toString()}");
    setState(() {
      if (selected == true) {
        if (!selectedProducts.any((p) => p.id == product.id)) {
          selectedProducts.add(product);
        }
      } else {
        selectedProducts.removeWhere((p) => p.id == product.id);
      }
    });
  }

  void buySelectedItems() {
    showCheckoutBottomSheet(context, (name, email) async {
      final order = OrderModel(
        items: selectedProducts,
        quantity:
            selectedProducts.fold(0, (total, item) => total + item.quantity),
        total: selectedProducts.fold(
            0, (total, item) => total + (item.price * item.quantity)),
        createdAt: DateTime.now().toUtc(),
        name: name,
        email: email,
      );
      try {
        await productsService.purchase(order);
        for (var i in selectedProducts) {
          await productsService.delProdFromCart(i.id!);
        }
        if (!mounted) return;
        setState(() {
          selectedProducts = [];
          _productsCartBuilder = productsService.getCartProducts();
        });

        showMessage(context, "Compra feita com sucesso!");
      } catch (e) {
        debugPrint("Erro ao efetuar a compra - $e");
        showMessage(context, "Erro ao efetuar a compra");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartModel>>(
        future: _productsCartBuilder,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Erro ao buscar produtos do carrinho!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Carrinho vazio!"));
          }
          final productsCart = snapshot.data!;
          return Scaffold(
            body: ListView.builder(
                padding: const EdgeInsets.all(7),
                itemCount: productsCart.length,
                itemBuilder: (context, index) {
                  final product = productsCart[index];
                  final isSelected =
                      selectedProducts.any((p) => p.id == product.id);
                  return Dismissible(
                    key: ValueKey(product.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(12),
                      color: Colors.red[300],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) async {
                      debugPrint(product.id);
                      //return;
                      try {
                        await productsService.delProdFromCart(product.id!);
                        if (!context.mounted) {
                          return;
                        }

                        selectedProducts.removeWhere((p) => p.id == product.id);
                        showMessage(context, "Produto removido do carrinho!");
                      } catch (e) {
                        if (!context.mounted) {
                          return;
                        }
                        debugPrint("Erro ao deletar item do carrinho!");

                        showMessage(
                            context, "Erro ao deletar item do carrinho");
                      }
                    },
                    child: CartItemCard(
                      key: ValueKey(product.id),
                      cartItem: product,
                      selected: isSelected,
                      updateList: () {
                        setState(() {
                          _productsCartBuilder =
                              productsService.getCartProducts();
                          toggleSelection(product, false);
                        });
                      },
                      onChanged: (bool? selected) =>
                          toggleSelection(product, selected),
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                buySelectedItems();
              },
              child: const Icon(Icons.attach_money),
            ),
          );
        });
  }
}
