import 'package:get_it/get_it.dart';
import 'package:restaurants_task/core/service/cache_service.dart';
import 'package:restaurants_task/core/service/network_service.dart';
import 'package:restaurants_task/features/home/data/datasources/home_local_data_source.dart';

import '../../features/favorites/data/datasources/favorites_local_data_source.dart';
import '../../features/favorites/data/datasources/favorites_remote_data_source.dart';
import '../../features/favorites/data/repositories/favorites_repository.dart';
import '../../features/favorites/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository.dart';
import '../../features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import '../../features/restaurant/data/repositories/restaurant_repository.dart';
import '../../features/restaurant/presentation/cubits/restaurant_cubit/restaurant_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Register Core
  sl.registerSingleton<NetworkService>(NetworkServiceImpl());
  sl.registerSingleton<CacheService>(CacheServiceImpl());

  // Register Features
  // HOME
  sl.registerFactory<HomeRepository>(() => HomeRepositoryImpl(
        homeRemoteDataSource: sl(),
        homeLocalDataSource: sl(),
      ));
  sl.registerFactory<HomeLocalDataSource>(() => HomeLocalDataSourceImpl(sl()));
  sl.registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl()));

  // Favorites
  sl.registerFactory<FavoritesCubit>(
      () => FavoritesCubit(favoritesRepository: sl()));
  sl.registerFactory<FavoritesRepository>(() => FavoritesRepositoryImpl(
        favoritesLocalDataSource: sl(),
        favoritesRemoteDataSource: sl(),
      ));
  sl.registerFactory<FavoritesLocalDataSource>(
      () => FavoritesLocalDataSourceImpl(sl()));
  sl.registerFactory<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSourceImpl(sl()));

  // Restaurant
  sl.registerFactory<RestaurantCubit>(() => RestaurantCubit(
        restaurantRepository: sl(),
      ));
  sl.registerFactory<RestaurantRepository>(
      () => RestaurantRepositoryImpl(restaurantRemoteDataSource: sl()));
  sl.registerFactory<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(sl()));
}
