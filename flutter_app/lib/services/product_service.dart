import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cart.dart';
import 'package:flutter_app/models/page.dart';
import 'package:flutter_app/models/products_model.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000/"));
  final Dio _dioProduct = Dio(BaseOptions(
      baseUrl: 'https://616d6bdb6dacbb001794ca17.mockapi.io/devnology/'));

  Future<PageModel> getProducts({
    int? page,
    FiltroModel? filters,
  }) async {
    final queryParams = {
      'page': page,
      'limit': 12,
      ...?filters?.toQueryParams(),
    };
    debugPrint('Query Params: $queryParams');
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

  Future<CartModel?> getProductFromCart(String id, String origin) async {
    try {
      final response = await _dio.get("cart/by-product/$id/$origin");

      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
    } catch (e) {
      debugPrint("Erro ao buscar o produto $id");
      rethrow;
    }
    return null;
  }

  Future<CartModel> addToCart(CartModel product) async {
    try {
      final response = await _dio.post("cart", data: product.toJson());
      return CartModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Erro ao adicionar o produto ${product.name} no carrinho");
      rethrow;
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      await _dio.delete("cart/$id");
      return;
    } catch (e) {
      debugPrint("Erro ao remover o produto $id do carrinho");
      rethrow;
    }
  }

  Future<List<CartModel>> getCartProducts() async {
    try {
      final response = await _dio.get("cart");
      return (response.data as List).map((i) => CartModel.fromJson(i)).toList();
    } catch (e) {
      debugPrint("Erro ao listar produtos do carrinho - $e");
      return [];
    }
  }

  Future<void> delProdFromCart(String id) async {
    try {
      await _dio.delete("cart/$id");
      return;
    } catch (e) {
      debugPrint("Erro ao apagar produto do carrinho - Produto: $e");
      return;
    }
  }

  Future<CartModel> updateCart(String id, int newQuantity) async {
    try {
      final response =
          await _dio.patch("cart/$id", data: {"quantity": newQuantity});
      return CartModel.fromJson(response.data);
    } catch (e) {
      debugPrint("Erro ao apagar produto do carrinho - Produto: $e");
      rethrow;
    }
  }

  Future<void> purchase(OrderModel order) async {
    try {
      final orderJson = order.toJson();
      debugPrint('Pedido enviado: ${jsonEncode(orderJson)}');
      await _dio.post("orders", data: orderJson);
    } catch (e) {
      debugPrint("Erro ao finalizar a compra! - $e");
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _dio.get("orders");
      return (response.data as List)
          .map((i) => OrderModel.fromJson(i))
          .toList();
    } catch (e) {
      debugPrint("Erro ao carregar lista de pedidos - Product Service - $e");
      rethrow;
    }
  }
}
