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
        emit(FoodLoaded(items));
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
        emit(FoodLoaded(resetItems));
      }
    });
  }
}
