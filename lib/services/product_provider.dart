import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Data> allProducts = [];

  Set<int> cartIds = {1, 2};
  Set<int> favoriteIds = {1, 2, 3, 4, 5, 6, 7, 8, 9};

  bool isLoading = false;
  String errorMessage = "";

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      ProductsModel data = await _apiService.fetchProducts();
      allProducts = data.data ?? [];
    } catch (e) {
      errorMessage = "Ürünler yüklenirken bir hata oluştu: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addCart(int productId) {
    if (!cartIds.contains(productId)) {
      cartIds.add(productId);
    }
    notifyListeners();
  }

  void removeCart(int productId) {
    if (cartIds.contains(productId)) {
      cartIds.remove(productId);
      notifyListeners();
    }
  }

  void toggleFavorite(int productId) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  int get cartCount => cartIds.length;
}
