import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/modal_filters.dart';
import 'package:flutter_app/models/page.dart';
import 'package:flutter_app/pages/Products/widgets/pagination_widget.dart';
import 'package:flutter_app/pages/Products/widgets/product_item_card_widget.dart';
import 'package:flutter_app/services/product_service.dart';
import 'package:flutter_app/services/service_locator.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final productsService = getIt<ProductService>();
  FiltroModel? filters;
  late FiltersModel _filtersList;

  PageModel? _pagination;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadProducts(filters);
    _loadProductsType();
  }

  void _loadProducts(FiltroModel? filters) async {
    final page =
        await productsService.getProducts(page: _currentPage, filters: filters);
    setState(() {
      _pagination = page;
    });
  }

  void _loadProductsType() async {
    final options = await productsService.getFilters();
    setState(() {
      _filtersList = options;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PageModel>(
        future:
            productsService.getProducts(page: _currentPage, filters: filters),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao buscar os produtos"));
          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado"));
          }
          final products = snapshot.data!.data;

          if (_pagination == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    openFilterDialog(context, _filtersList,
                        (FiltroModel filtersToAdd) {
                      setState(() {
                        filters = filtersToAdd;
                        _loadProducts(filters);
                        _currentPage = 1;
                      });
                    });
                  },
                  child: Text("Filtros")),
              if (filters != null)
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filters = null;
                        _loadProducts(filters);
                        _currentPage = 1;
                      });
                    },
                    child: Text("Limpar Filtros")),
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
                  totalPages: _pagination?.totalPages ?? 1,
                  firstPage: () {
                    setState(() {
                      _currentPage = 1;
                    });
                    _loadProducts(filters);
                  },
                  lastPage: () {
                    setState(() {
                      _currentPage = _pagination?.totalPages ?? 1;
                    });
                    _loadProducts(filters);
                  },
                  onPrevious: () {
                    if (_currentPage > 1) {
                      setState(() {
                        _currentPage--;
                      });
                      _loadProducts(filters);
                    }
                  },
                  onNext: () {
                    if (_currentPage < (_pagination?.totalPages ?? 1)) {
                      setState(() {
                        _currentPage++;
                      });
                      _loadProducts(filters);
                    }
                  })
            ],
          );
        });
  }
}
