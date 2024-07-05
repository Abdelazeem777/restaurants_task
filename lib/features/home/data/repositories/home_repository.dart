import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';

abstract class HomeRepository {}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource homeRemoteDataSource,
    required HomeLocalDataSource homeLocalDataSource,
  })  : _remoteDataSource = homeRemoteDataSource,
        _localDataSource = homeLocalDataSource;

  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
}
