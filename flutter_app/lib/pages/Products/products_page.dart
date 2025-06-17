import 'package:flutter/material.dart';
import 'package:flutter_app/models/page.dart';
import 'package:flutter_app/pages/Products/widgets/product_item_card_widget.dart';
import 'package:flutter_app/services/product_service.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductService productsService = ProductService();

  late List<ProductModel> _products = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    _loading = true;
    final page = await productsService.getProducts();
    _loading = false;
    setState(() {
      _products = page.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productsService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao buscar os produtos"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado"));
          }
          final products = snapshot.data!.data;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItemCardWidget(product: product);
            },
          );
        });
  }
}
