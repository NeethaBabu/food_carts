part of 'food_bloc.dart';

abstract class FoodState {}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodModel> items;

  FoodLoaded({required this.items});
}

class FoodError extends FoodState {
  final String message;

  FoodError(this.message);
}
