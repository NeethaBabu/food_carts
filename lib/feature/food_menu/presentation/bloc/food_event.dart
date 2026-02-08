part of 'food_bloc.dart';

abstract class FoodEvent {}

class FetchFoodMenu extends FoodEvent {}

class ResetFoodMenu extends FoodEvent {}
