import '../datasources/favorites_remote_data_source.dart';

abstract class FavoritesRepository {

}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
  }) : _remoteDataSource = favoritesRemoteDataSource;

}
