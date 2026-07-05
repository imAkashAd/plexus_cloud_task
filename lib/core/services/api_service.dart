import 'package:plexus_task/core/services/api_endpoints.dart';
import 'package:plexus_task/core/services/network_caller.dart';

class ApiService {
  static Future<dynamic> login({required Map<String, dynamic> body}) async {
    final response = await NetworkCaller.postRequest(
      url: ApiEndpoints.login,
      body: body,
    );
    return response.data;
  }

  static Future<dynamic> getProducts() async {
    final response = await NetworkCaller.getRequest(
      url: ApiEndpoints.products,
    );
    return response.data;
  }

  static Future<dynamic> getCategories() async {
    final response = await NetworkCaller.getRequest(
      url: ApiEndpoints.categories,
    );
    return response.data;
  }
}
