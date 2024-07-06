import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurants_task/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart';
import 'package:restaurants_task/features/restaurant/data/repositories/restaurant_repository.dart';

class RestaurantRemoteDataSourceMock extends Mock
    implements RestaurantRemoteDataSource {}

void main() {
  late RestaurantRemoteDataSourceMock remoteDataSourceMock;
  late RestaurantRepository repository;

  setUp(() {
    remoteDataSourceMock = RestaurantRemoteDataSourceMock();
    repository = RestaurantRepositoryImpl(
        restaurantRemoteDataSource: remoteDataSourceMock);
  });

  group("getRestaurants", () {
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
    test('should return list of Place when the response code is 200', () async {
      // arrange
      when(() => remoteDataSourceMock.getRestaurants(
            query: any(named: 'query'),
            latLng: any(named: 'latLng'),
            limit: any(named: 'limit'),
          )).thenAnswer(
        (_) async => places,
      );
      // act
      final result =
          await repository.getRestaurants(query: 'query', latLng: '0.0,0.0');
      // assert
      expect(result, places);
    });
  });

  group("getRestaurantDetail", () {
    final place = Place(
        fsqId: '1',
        categories: [],
        chains: [],
        closedBucket: '',
        distance: 1,
        geocodes: Geocodes(main: Geocode(latitude: 0.0, longitude: 0.0)),
        link: '',
        location: Location(
            country: '', formattedAddress: '', locality: '', region: ''),
        name: '',
        timezone: '');
    test('should return Place when the response code is 200', () async {
      // arrange
      when(() => remoteDataSourceMock.getRestaurantDetail(any())).thenAnswer(
        (_) async => place,
      );
      // act
      final result = await repository.getRestaurantDetail('1');
      // assert
      expect(result, place);
    });
  });
}
