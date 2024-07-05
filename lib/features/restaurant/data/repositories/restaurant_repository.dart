import '../datasources/restaurant_remote_data_source.dart';

abstract class RestaurantRepository {

}

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource _remoteDataSource;

  RestaurantRepositoryImpl({
    required RestaurantRemoteDataSource restaurantRemoteDataSource,
  }) : _remoteDataSource = restaurantRemoteDataSource;

}
