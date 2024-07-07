import '../../../restaurant/data/models/place_model.dart';
import '../datasources/favorites_local_data_source.dart';

abstract class FavoritesRepository {
  Future<List<Place>> getFavorites();
  Future<void> addFavorite(Place place);
  Future<void> removeFavorite(Place place);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _localDataSource;

  FavoritesRepositoryImpl(FavoritesLocalDataSource favoritesLocalDataSource)
      : _localDataSource = favoritesLocalDataSource;

  @override
  Future<void> addFavorite(Place place) => _localDataSource.addFavorite(place);

  @override
  Future<List<Place>> getFavorites() => _localDataSource.getFavorites();

  @override
  Future<void> removeFavorite(Place place) =>
      _localDataSource.removeFavorite(place);
}
