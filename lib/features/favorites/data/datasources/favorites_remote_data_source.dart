import '../../../../core/service/network_service.dart';

abstract class FavoritesRemoteDataSource {
 
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final NetworkService _networkService;
  FavoritesRemoteDataSourceImpl(this._networkService);
 
}
