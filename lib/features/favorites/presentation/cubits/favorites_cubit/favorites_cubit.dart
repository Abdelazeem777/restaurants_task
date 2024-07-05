
import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../data/repositories/favorites_repository.dart';
part 'favorites_state.dart';

class FavoritesCubit extends BaseCubit<FavoritesState> {
  FavoritesCubit({
    required FavoritesRepository favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(const FavoritesState());

  final FavoritesRepository _favoritesRepository;
  

  
    }
  

