import '../../../../core/service/cache_service.dart';

abstract class HomeLocalDataSource {}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final CacheService _cacheService;
  HomeLocalDataSourceImpl(this._cacheService);
}
