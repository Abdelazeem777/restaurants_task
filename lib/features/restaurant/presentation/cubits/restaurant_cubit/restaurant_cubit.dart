import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restaurants_task/core/service/location_service.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/restaurant_repository.dart';
part 'restaurant_state.dart';

class RestaurantCubit extends BaseCubit<RestaurantState> {
  RestaurantCubit({
    required RestaurantRepository restaurantRepository,
    required LocationService locationService,
  })  : _restaurantRepository = restaurantRepository,
        _locationService = locationService,
        super(const RestaurantState());

  final RestaurantRepository _restaurantRepository;
  final LocationService _locationService;

  Future<void> init() async {
    emit(state.copyWith(status: RestaurantStateStatus.loading));
    final location = await _locationService.getMyLocation();
    emit(state.copyWith(
      status: RestaurantStateStatus.loaded,
      currentLocation: location,
    ));
  }

  Future<void> loadRestaurants({
    String? query,
    bool refresh = false,
  }) async {
    emit(state.copyWith(
      status: RestaurantStateStatus.loadingRestaurants,
      searchQuery: query,
    ));

    try {
      final location = await _locationService.getMyLocation();
      final restaurants = await _restaurantRepository.getRestaurants(
        query: query ?? '',
        latLng: _latLongStringFromPosition(location!),
      );
      emit(state.copyWith(
        status: RestaurantStateStatus.loaded,
        restaurants: restaurants,
        searchQuery: query,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RestaurantStateStatus.error,
        errorMessage: e.toString(),
        searchQuery: query,
      ));
    }
  }

  String _latLongStringFromPosition(Position position) =>
      '${position.latitude},${position.longitude}';

  Future<void> search(String query) => loadRestaurants(query: query);

  void refresh() => loadRestaurants(query: state.searchQuery, refresh: true);
}
