import 'package:flutter/material.dart';
import 'package:flutter_app/models/page.dart';
import 'package:flutter_app/pages/Products/widgets/pagination_widget.dart';
import 'package:flutter_app/pages/Products/widgets/product_item_card_widget.dart';
import 'package:flutter_app/services/product_service.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductService productsService = ProductService();

  late PageModel _pagination;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadProductsType();
  }

  void _loadProducts() async {
    final page = await productsService.getProducts(page: _currentPage);

    setState(() {
      _pagination = page;
    });
  }

  void _loadProductsType() async {
    final options = await productsService.getFilters();
    setState(() {
      // _options = options;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productsService.getProducts(page: _currentPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao buscar os produtos"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado"));
          }
          final products = snapshot.data!.data;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItemCardWidget(product: product);
                  },
                ),
              ),
              PaginationWidget(
                  currentPage: _currentPage,
                  totalPages: _pagination.totalPages,
                  onPrevious: () {
                    if (_currentPage > 1) {
                      setState(() {
                        _currentPage--;
                      });
                      _loadProducts();
                    }
                  },
                  onNext: () {
                    if (_currentPage < (_pagination.totalPages)) {
                      setState(() {
                        _currentPage++;
                      });
                      _loadProducts();
                    }
                  })
            ],
          );
        });
  }
}
