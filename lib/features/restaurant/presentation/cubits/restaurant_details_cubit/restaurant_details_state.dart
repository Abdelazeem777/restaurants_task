part of 'restaurant_details_cubit.dart';

enum RestaurantDetailsStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension RestaurantDetailsStateX on RestaurantDetailsState {
  bool get isInitial => status == RestaurantDetailsStateStatus.initial;
  bool get isLoading => status == RestaurantDetailsStateStatus.loading;
  bool get isLoaded => status == RestaurantDetailsStateStatus.loaded;
  bool get isError => status == RestaurantDetailsStateStatus.error;
}

@immutable
class RestaurantDetailsState {
  final RestaurantDetailsStateStatus status;
  final String? errorMessage;
  final Place? currentRestaurant;

  const RestaurantDetailsState({
    this.status = RestaurantDetailsStateStatus.initial,
    this.errorMessage,
    this.currentRestaurant,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as RestaurantDetailsState).status == status &&
        other.errorMessage == errorMessage &&
        other.currentRestaurant == currentRestaurant;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ currentRestaurant.hashCode;

  RestaurantDetailsState copyWith({
    RestaurantDetailsStateStatus? status,
    String? errorMessage,
    Place? currentRestaurant,
  }) {
    return RestaurantDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentRestaurant: currentRestaurant ?? this.currentRestaurant,
    );
  }
}
