import '../datasources/favorites_local_data_source.dart';
import '../datasources/favorites_remote_data_source.dart';

abstract class FavoritesRepository {}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;
  final FavoritesLocalDataSource _localDataSource;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
    required FavoritesLocalDataSource favoritesLocalDataSource,
  })  : _remoteDataSource = favoritesRemoteDataSource,
        _localDataSource = favoritesLocalDataSource;
}
