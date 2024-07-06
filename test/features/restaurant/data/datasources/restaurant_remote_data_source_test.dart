import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurants_task/api_end_point.dart';
import 'package:restaurants_task/core/exceptions/request_exception.dart';
import 'package:restaurants_task/core/service/network_service.dart';
import 'package:restaurants_task/features/restaurant/data/datasources/restaurant_remote_data_source.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart';

class NetworkServiceMock extends Mock implements NetworkService {}

void main() {
  late NetworkServiceMock networkServiceMock;
  late RestaurantRemoteDataSource restaurantRemoteDataSource;

  setUp(() {
    networkServiceMock = NetworkServiceMock();
    restaurantRemoteDataSource =
        RestaurantRemoteDataSourceImpl(networkServiceMock);
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
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.SEARCH_PLACE),
          statusCode: 200,
          data: {
            'data': places.map((e) => e.toMap()).toList(),
          },
        ),
      );
      // act
      final result = await restaurantRemoteDataSource.getRestaurants(
          query: 'query', latLng: '0.0,0.0');
      // assert
      expect(result, places);
    });

    test('should throw RequestException when the response code is not 200',
        () async {
      // arrange
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.SEARCH_PLACE),
          statusCode: 400,
          data: 'error',
        ),
      );
      // act
      Future call() async => await restaurantRemoteDataSource.getRestaurants(
          query: 'query', latLng: '0.0,0.0');
      // assert
      expect(() => call(), throwsA(isA<RequestException>()));
    });

    test('should throw RequestException when the response data is not a list',
        () async {
      // arrange
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.SEARCH_PLACE),
          statusCode: 200,
          data: {
            'data': {},
          },
        ),
      );
      // act
      Future call() async => await restaurantRemoteDataSource.getRestaurants(
          query: 'query', latLng: '0.0,0.0');
      // assert
      expect(() => call(), throwsA(isA<RequestException>()));
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
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.DETAIL_PLACE),
          statusCode: 200,
          data: {
            'data': place.toMap(),
          },
        ),
      );
      // act
      final result = await restaurantRemoteDataSource.getRestaurantDetail('1');
      // assert
      expect(result, place);
    });

    test('should throw RequestException when the response code is not 200',
        () async {
      // arrange
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.DETAIL_PLACE),
          statusCode: 400,
          data: 'error',
        ),
      );
      // act
      Future call() async =>
          await restaurantRemoteDataSource.getRestaurantDetail('1');
      // assert
      expect(() => call(), throwsA(isA<RequestException>()));
    });

    test('should throw RequestException when the response data is not a map',
        () async {
      // arrange
      when(() => networkServiceMock.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(baseUrl: ApiEndPoint.DETAIL_PLACE),
          statusCode: 200,
          data: {
            'data': [],
          },
        ),
      );
      // act
      Future call() async =>
          await restaurantRemoteDataSource.getRestaurantDetail('1');
      // assert
      expect(() => call(), throwsA(isA<RequestException>()));
    });
  });
}
