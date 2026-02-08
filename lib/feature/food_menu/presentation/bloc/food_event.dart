part of 'food_bloc.dart';

abstract class FoodEvent {}

class FetchFoodMenu extends FoodEvent {}

class ResetFoodMenu extends FoodEvent {}

class UpdateFoodQuantity extends FoodEvent {
  final String foodId;
  final int quantity;

  UpdateFoodQuantity({required this.foodId, required this.quantity});
}
