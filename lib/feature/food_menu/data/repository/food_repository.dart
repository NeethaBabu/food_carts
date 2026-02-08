import '../datasource/food_remote_datasource.dart';
import '../model/food_model.dart';

class FoodRepository {
  final FoodRemoteDataSource remote;

  FoodRepository(this.remote);

  Future<List<FoodModel>> getMenu() {
    return remote.fetchMenu();
  }
}
