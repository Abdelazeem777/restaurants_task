import 'package:restaurants_task/features/restaurant/data/models/place_model.dart';

import '../../../../api_end_point.dart';
import '../../../../core/exceptions/request_exception.dart';
import '../../../../core/service/network_service.dart';

const _RESTAURANTS_CATEGORY_ID = '13065';

abstract class RestaurantRemoteDataSource {
  Future<List<Place>> getRestaurants({
    required String query,
    required String latLng,
    List<String> categories = const [_RESTAURANTS_CATEGORY_ID],
    int limit = 10,
  });

  Future<Place> getRestaurantDetail(String id);
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final NetworkService _networkService;
  RestaurantRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<Place>> getRestaurants({
    required String query,
    required String latLng,
    List<String> categories = const [_RESTAURANTS_CATEGORY_ID],
    int limit = 10,
  }) async {
    const url = ApiEndPoint.SEARCH_PLACE;

    final params = {
      'query': query,
      'll': latLng,
      'categoryId': categories.join(','),
      'limit': limit,
    };
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      if (result['data'] is! List) throw RequestException(result['data']);
      final data = result['data'] as List;
      return data.map((e) => Place.fromMap(e)).toList();
    });
  }

  @override
  Future<Place> getRestaurantDetail(String id) async {
    const url = ApiEndPoint.DETAIL_PLACE;

    final params = {
      'fsq_id': id,
    };
    return _networkService.get(url, queryParameters: params).then((response) {
      if (response.statusCode != 200) throw RequestException(response.data);
      final result = response.data;
      if (result['data'] is! Map) throw RequestException(result['data']);

      final data = result['data'] as Map<String, dynamic>;
      return Place.fromMap(data);
    });
  }
}
