import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plexus_task/core/services/storage_service.dart';
import 'package:plexus_task/features/products/models/product_model.dart';
import 'package:plexus_task/features/products/repository/products_repository.dart';

class ProductsController extends ChangeNotifier {
  final ProductsRepository _repository;

  ProductsController(this._repository) {
    loadFavorites();
  }

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  List<String> _categories = [];
  List<String> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  String _sortBy = 'none'; // 'none', 'priceAsc', 'priceDesc', 'rating'
  String get sortBy => _sortBy;

  final Set<int> _favoriteIds = {};
  Set<int> get favoriteIds => _favoriteIds;

  void loadFavorites() {
    final list = StorageService.sharedPreferences?.getStringList('favorite_product_ids');
    if (list != null) {
      _favoriteIds.clear();
      _favoriteIds.addAll(list.map((id) => int.tryParse(id) ?? 0).where((id) => id != 0));
    }
  }

  Future<void> toggleFavorite(int productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    await StorageService.sharedPreferences?.setStringList(
      'favorite_product_ids',
      _favoriteIds.map((id) => id.toString()).toList(),
    );
  }

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  List<ProductModel> get favoriteProducts {
    return _products.where((p) => _favoriteIds.contains(p.id)).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortBy(String sort) {
    _sortBy = sort;
    notifyListeners();
  }

  Future<void> fetchProducts({bool force = false}) async {
    if (_products.isNotEmpty && !force) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_categories.isEmpty) {
        _categories = await _repository.fetchCategories();
      }

      _products = await _repository.fetchProducts();

      // Save to offline cache
      final jsonStr = jsonEncode(_products.map((p) => p.toJson()).toList());
      await StorageService.sharedPreferences?.setString('cached_products', jsonStr);

      final catJson = jsonEncode(_categories);
      await StorageService.sharedPreferences?.setString('cached_categories', catJson);
    } catch (e) {
      // Attempt loading from local cache
      final cachedStr = StorageService.sharedPreferences?.getString('cached_products');
      final cachedCatStr = StorageService.sharedPreferences?.getString('cached_categories');
      if (cachedStr != null && cachedCatStr != null) {
        final List decoded = jsonDecode(cachedStr);
        _products = decoded.map((json) => ProductModel.fromJson(json)).toList();

        final List decodedCat = jsonDecode(cachedCatStr);
        _categories = decodedCat.map((e) => e.toString()).toList();
        _errorMessage = "Offline Mode: Showing cached data.";
      } else {
        _errorMessage = e.toString();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ProductModel> get filteredProducts {
    List<ProductModel> result = List.from(_products);

    // Filter by category
    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      result = result.where((p) => p.category == _selectedCategory).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((p) =>
          p.title.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query)).toList();
    }

    // Apply sorting choice
    if (_sortBy == 'priceAsc') {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'priceDesc') {
      result.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'rating') {
      result.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
    }

    return result;
  }
}
