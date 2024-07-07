import 'package:flutter/foundation.dart';
import '../../../../../../core/abstract/base_cubit.dart';
import '../../../../restaurant/data/models/place_model.dart';
import '../../../data/repositories/favorites_repository.dart';
part 'favorites_state.dart';

class FavoritesCubit extends BaseCubit<FavoritesState> {
  FavoritesCubit({
    required FavoritesRepository favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(const FavoritesState());

  final FavoritesRepository _favoritesRepository;

  Future<void> loadFavorites([bool refresh = false]) async {
    if (!refresh) emit(state.copyWith(status: FavoritesStateStatus.loading));
    try {
      final favorites = await _favoritesRepository.getFavorites();
      emit(state.copyWith(
        status: FavoritesStateStatus.loaded,
        favorites: favorites,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh() => loadFavorites(true);

  Future<void> addFavorite(Place place) async {
    await _favoritesRepository.addFavorite(place);

    final favorites = [...?state.favorites];
    favorites.add(place);

    emit(state.copyWith(favorites: favorites));
  }

  Future<void> removeFavorite(Place place) async {
    await _favoritesRepository.removeFavorite(place);

    final favorites = [...?state.favorites];
    favorites.remove(place);

    emit(state.copyWith(favorites: favorites));
  }
}
