import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/food_model.dart';
import '../../data/repository/food_repository.dart';

part 'food_event.dart';

part 'food_state.dart';


class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository repository;

  FoodBloc(this.repository) : super(FoodInitial()) {
    on<FetchFoodMenu>((event, emit) async {
      emit(FoodLoading());
      try {
        final items = await repository.getMenu();
        emit(FoodLoaded(items: items));
      } catch (e) {
        emit(FoodError(e.toString()));
      }
    });

    on<ResetFoodMenu>((event, emit) {
      final currentState = state;
      if (currentState is FoodLoaded) {
        final resetItems = currentState.items
            .map((e) => e.copyWith(quantity: 0))
            .toList();

        emit(FoodLoaded(items: resetItems));
      }
    });

    on<UpdateFoodQuantity>((event, emit) {
      if (state is FoodLoaded) {
        final currentState = state as FoodLoaded;

        final updatedItems = currentState.items.map((item) {
          if (item.id == event.foodId) {
            return item.copyWith(quantity: event.quantity);
          }
          return item;
        }).toList();

        emit(FoodLoaded(items: updatedItems));
      }
    });
  }
}
