import 'package:flutter/foundation.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/restaurant_repository.dart';
part 'restaurant_details_state.dart';

class RestaurantDetailsCubit extends BaseCubit<RestaurantDetailsState> {
  RestaurantDetailsCubit({
    required RestaurantRepository restaurantRepository,
  })  : _restaurantRepository = restaurantRepository,
        super(const RestaurantDetailsState());

  final RestaurantRepository _restaurantRepository;

  Future<void> loadRestaurantDetails(String id, [bool refresh = false]) async {
    if (!refresh)
      emit(state.copyWith(status: RestaurantDetailsStateStatus.loading));
    try {
      final restaurantDetails =
          await _restaurantRepository.getRestaurantDetail(id);
      emit(state.copyWith(
        status: RestaurantDetailsStateStatus.loaded,
        currentRestaurant: restaurantDetails,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RestaurantDetailsStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh(String id) => loadRestaurantDetails(id, true);
}
