import 'package:plexus_task/core/services/api_service.dart';
import 'package:plexus_task/features/products/models/product_model.dart';

class ProductsRepository {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final responseData = await ApiService.getProducts();
      if (responseData is List) {
        return responseData
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception("Unexpected products response format");
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }

  Future<List<String>> fetchCategories() async {
    try {
      final responseData = await ApiService.getCategories();
      if (responseData is List) {
        return responseData.map((e) => e.toString()).toList();
      }
      throw Exception("Unexpected categories response format");
    } catch (e) {
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    }
  }
}
