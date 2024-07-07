part of 'restaurant_cubit.dart';

enum RestaurantStateStatus {
  initial,
  loading,
  loaded,
  loadingRestaurants,
  error,
}

extension RestaurantStateX on RestaurantState {
  bool get isInitial => status == RestaurantStateStatus.initial;
  bool get isLoading => status == RestaurantStateStatus.loading;
  bool get isLoaded => status == RestaurantStateStatus.loaded;
  bool get isLoadingRestaurants =>
      status == RestaurantStateStatus.loadingRestaurants;
  bool get isError => status == RestaurantStateStatus.error;
}

@immutable
class RestaurantState {
  final RestaurantStateStatus status;
  final String? errorMessage;
  final List<Place>? restaurants;
  final String? searchQuery;
  final Position? currentLocation;

  const RestaurantState({
    this.status = RestaurantStateStatus.initial,
    this.errorMessage,
    this.restaurants,
    this.searchQuery,
    this.currentLocation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as RestaurantState).status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.restaurants, restaurants) &&
        other.searchQuery == searchQuery &&
        other.currentLocation == currentLocation;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      restaurants.hashCode ^
      searchQuery.hashCode ^
      currentLocation.hashCode;

  RestaurantState copyWith({
    RestaurantStateStatus? status,
    String? errorMessage,
    List<Place>? restaurants,
    String? searchQuery,
    Position? currentLocation,
  }) {
    return RestaurantState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurants: restaurants ?? this.restaurants,
      searchQuery: searchQuery ?? this.searchQuery,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
