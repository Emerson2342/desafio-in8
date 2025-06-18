import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/page.dart';
import 'package:flutter_app/models/products_model.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000/"));
  final Dio _dioProduct = Dio(BaseOptions(
      baseUrl: 'https://616d6bdb6dacbb001794ca17.mockapi.io/devnology/'));

  Future<PageModel> getProducts({
    int? page,
    double? min,
    double? max,
    String? material,
    String? tipo,
  }) async {
    final queryParams = {
      'page': page,
      'limit': 12,
      if (min != null) 'min': min,
      if (max != null) 'max': max,
      if (material != null && material.isNotEmpty) 'material': material,
      if (tipo != null && tipo.isNotEmpty) 'tipo': tipo,
    };
    try {
      final response = await _dio.get(
        'products',
        queryParameters: queryParams,
      );
      return PageModel.fromJson(response.data);
    } catch (e) {
      debugPrint('Erro ao buscar produtos: $e');

      rethrow;
    }
  }

  Future<FiltersModel> getFilters() async {
    try {
      final response = await _dio.get("products/filters");
      return FiltersModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Erro ao listar os tipos de produtos $e");
      rethrow;
    }
  }

  Future<ProductBRModel> getProductBRById(String id) async {
    try {
      final response = await _dioProduct.get("brazilian_provider/$id");
      return ProductBRModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Erro ao buscar o produto $id");
      rethrow;
    }
  }

  Future<ProductEUModel> getProductEUById(String id) async {
    try {
      final response = await _dioProduct.get("european_provider/$id");
      return ProductEUModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Erro ao buscar o produto $id");
      rethrow;
    }
  }
}
