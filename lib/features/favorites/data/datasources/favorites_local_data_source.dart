import '../../../../core/service/cache_service.dart';

abstract class FavoritesLocalDataSource {}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final CacheService _cacheService;
  FavoritesLocalDataSourceImpl(this._cacheService);
}
