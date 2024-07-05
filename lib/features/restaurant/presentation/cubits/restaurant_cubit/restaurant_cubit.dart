
import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/restaurant_repository.dart';
part 'restaurant_state.dart';

class RestaurantCubit extends BaseCubit<RestaurantState> {
  RestaurantCubit({
    required RestaurantRepository restaurantRepository,
  })  : _restaurantRepository = restaurantRepository,
        super(const RestaurantState());

  final RestaurantRepository _restaurantRepository;
  

  
    }
  

