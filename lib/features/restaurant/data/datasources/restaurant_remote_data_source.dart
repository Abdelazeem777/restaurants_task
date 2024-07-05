import '../../../../core/service/network_service.dart';

abstract class RestaurantRemoteDataSource {
 
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final NetworkService _networkService;
  RestaurantRemoteDataSourceImpl(this._networkService);
 
}
