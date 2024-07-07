import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurants_task/core/service/cache_service.dart';
import 'package:restaurants_task/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart';

class CacheServiceMock extends Mock implements CacheService {}

void main() {
  late CacheServiceMock cacheServiceMock;
  late FavoritesLocalDataSource favoritesLocalDataSource;

  setUp(() {
    cacheServiceMock = CacheServiceMock();
    favoritesLocalDataSource = FavoritesLocalDataSourceImpl(cacheServiceMock);
  });

  group("getFavorites", () {
    test('should return list of Place when the data Exists in cache', () async {
      // arrange
      final places = List.generate(
          5,
          (i) => Place(
              fsqId: '$i',
              categories: [],
              chains: [],
              closedBucket: '',
              distance: i,
              geocodes: Geocodes(main: Geocode(latitude: 0.0, longitude: 0.0)),
              link: '',
              location: Location(
                  country: '', formattedAddress: '', locality: '', region: ''),
              name: '',
              timezone: ''));
      when(() => cacheServiceMock.getString(any()))
          .thenAnswer((_) async => places.map((e) => e.toJson()).join(","));
      // act`
      final result = await favoritesLocalDataSource.getFavorites();
      // assert
      expect(result, places);
    });

    test('should return empty list when the response code is 200', () async {
      // arrange
      when(() => cacheServiceMock.getString(any()))
          .thenAnswer((_) async => null);
      // act
      final result = await favoritesLocalDataSource.getFavorites();
      // assert
      expect(result, []);
    });
  });

  group("addFavorite", () {});

  group("removeFavorite", () {});
}
