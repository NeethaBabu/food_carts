import '../../../../core/network/dio_client.dart';
import '../model/food_model.dart';

class FoodRemoteDataSource {
  Future<List<FoodModel>> fetchMenu() async {
    final response = await DioClient.dio.get("menu.json");

    final data = response.data;
    if (data == null || data['categories'] == null) {
      throw Exception("No categories found in API");
    }

    final List<dynamic> categories = data['categories'];
    final List<FoodModel> allDishes = [];

    for (var category in categories) {
      final String categoryName = category['name'] ?? "Unknown";
      final List<dynamic> dishes = category['dishes'] ?? [];

      for (var dish in dishes) {
        allDishes.add(FoodModel.fromJson(dish, categoryName));
      }
    }

    return allDishes;
  }
}
