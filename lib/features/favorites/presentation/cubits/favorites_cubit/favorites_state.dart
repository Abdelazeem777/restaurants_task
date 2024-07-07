part of 'favorites_cubit.dart';

enum FavoritesStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension FavoritesStateX on FavoritesState {
  bool get isInitial => status == FavoritesStateStatus.initial;
  bool get isLoading => status == FavoritesStateStatus.loading;
  bool get isLoaded => status == FavoritesStateStatus.loaded;
  bool get isError => status == FavoritesStateStatus.error;
}

@immutable
class FavoritesState {
  final FavoritesStateStatus status;
  final String? errorMessage;
  final List<Place>? favorites;

  const FavoritesState({
    this.status = FavoritesStateStatus.initial,
    this.errorMessage,
    this.favorites,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as FavoritesState).status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.favorites, favorites);
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ favorites.hashCode;

  FavoritesState copyWith({
    FavoritesStateStatus? status,
    String? errorMessage,
    List<Place>? favorites,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      favorites: favorites ?? this.favorites,
    );
  }
}
