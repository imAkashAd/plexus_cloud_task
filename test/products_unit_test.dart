import 'package:flutter_test/flutter_test.dart';
import 'package:plexus_task/features/products/models/product_model.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/features/products/repository/products_repository.dart';

// Mock repository for testing
class MockProductsRepository extends ProductsRepository {
  final List<ProductModel> mockProducts;

  MockProductsRepository(this.mockProducts);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    return mockProducts;
  }

  @override
  Future<List<String>> fetchCategories() async {
    return ['electronics', 'clothing'];
  }
}

void main() {
  group('ProductModel Tests', () {
    test('ProductModel should parse correctly from JSON', () {
      final json = {
        "id": 1,
        "title": "Test Product",
        "price": 99.99,
        "description": "Test description",
        "category": "electronics",
        "image": "https://example.com/image.png",
        "rating": {"rate": 4.5, "count": 10}
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 1);
      expect(product.title, "Test Product");
      expect(product.price, 99.99);
      expect(product.category, "electronics");
      expect(product.rating.rate, 4.5);
      expect(product.rating.count, 10);
    });
  });

  group('ProductsController Filtering & Sorting Tests', () {
    late List<ProductModel> testProducts;
    late MockProductsRepository mockRepo;
    late ProductsController controller;

    setUp(() {
      testProducts = [
        ProductModel(
          id: 1,
          title: "Product A",
          price: 50.0,
          description: "Desc A",
          category: "electronics",
          image: "",
          rating: ProductRating(rate: 4.0, count: 5),
        ),
        ProductModel(
          id: 2,
          title: "Product B",
          price: 20.0,
          description: "Desc B",
          category: "clothing",
          image: "",
          rating: ProductRating(rate: 4.8, count: 8),
        ),
        ProductModel(
          id: 3,
          title: "Product C",
          price: 100.0,
          description: "Desc C",
          category: "electronics",
          image: "",
          rating: ProductRating(rate: 3.5, count: 12),
        ),
      ];

      mockRepo = MockProductsRepository(testProducts);
      controller = ProductsController(mockRepo);
    });

    test('should load products and cache them', () async {
      await controller.fetchProducts();

      expect(controller.products.length, 3);
      expect(controller.errorMessage, isNull);
    });

    test('should filter products by category', () async {
      await controller.fetchProducts();
      controller.setSelectedCategory('electronics');

      final filtered = controller.filteredProducts;

      expect(filtered.length, 2);
      expect(filtered.every((p) => p.category == 'electronics'), isTrue);
    });

    test('should search products by query', () async {
      await controller.fetchProducts();
      controller.setSearchQuery('product b');

      final filtered = controller.filteredProducts;

      expect(filtered.length, 1);
      expect(filtered.first.title, "Product B");
    });

    test('should sort products by price ascending', () async {
      await controller.fetchProducts();
      controller.setSortBy('priceAsc');

      final sorted = controller.filteredProducts;

      expect(sorted.length, 3);
      expect(sorted[0].price, 20.0); // Product B
      expect(sorted[1].price, 50.0); // Product A
      expect(sorted[2].price, 100.0); // Product C
    });

    test('should sort products by price descending', () async {
      await controller.fetchProducts();
      controller.setSortBy('priceDesc');

      final sorted = controller.filteredProducts;

      expect(sorted.length, 3);
      expect(sorted[0].price, 100.0); // Product C
      expect(sorted[1].price, 50.0); // Product A
      expect(sorted[2].price, 20.0); // Product B
    });

    test('should sort products by highest rating', () async {
      await controller.fetchProducts();
      controller.setSortBy('rating');

      final sorted = controller.filteredProducts;

      expect(sorted.length, 3);
      expect(sorted[0].rating.rate, 4.8); // Product B
      expect(sorted[1].rating.rate, 4.0); // Product A
      expect(sorted[2].rating.rate, 3.5); // Product C
    });
  });
}
