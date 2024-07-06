import '../datasources/restaurant_remote_data_source.dart';
import '../models/place_model.dart';

abstract class RestaurantRepository {
  Future<List<Place>> getRestaurants({
    required String query,
    required String latLng,
    int limit = 10,
  });

  Future<Place> getRestaurantDetail(String id);
}

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource _remoteDataSource;

  RestaurantRepositoryImpl({
    required RestaurantRemoteDataSource restaurantRemoteDataSource,
  }) : _remoteDataSource = restaurantRemoteDataSource;

  @override
  Future<List<Place>> getRestaurants({
    required String query,
    required String latLng,
    int limit = 10,
  }) =>
      _remoteDataSource.getRestaurants(
        query: query,
        latLng: latLng,
        limit: limit,
      );

  @override
  Future<Place> getRestaurantDetail(String id) =>
      _remoteDataSource.getRestaurantDetail(id);
}
