import '../../../../core/service/cache_service.dart';
import '../../../restaurant/data/models/place_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<Place>> getFavorites();
  Future<void> addFavorite(Place place);
  Future<void> removeFavorite(Place place);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final CacheService _cacheService;
  FavoritesLocalDataSourceImpl(this._cacheService);

  static const _FAVORITES = "FAVORITES";

  @override
  Future<void> addFavorite(Place place) async {
    final favorites = await getFavorites();
    favorites.add(place);
    await _cacheService.setString(_FAVORITES, _convertListToString(favorites));
  }

  String _convertListToString(List<Place> favorites) =>
      favorites.map((e) => e.toJson()).join(",");

  @override
  Future<List<Place>> getFavorites() async {
    final favorites = await _cacheService.getString(_FAVORITES);
    if (favorites == null) return [];
    return favorites.split(",").map((e) => Place.fromJson(e)).toList();
  }

  @override
  Future<void> removeFavorite(Place place) async {
    final favorites = await getFavorites();
    favorites.remove(place);
    await _cacheService.setString(_FAVORITES, _convertListToString(favorites));
  }
}
