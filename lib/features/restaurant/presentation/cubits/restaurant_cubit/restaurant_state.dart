part of 'restaurant_cubit.dart';

enum RestaurantStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension RestaurantStateX on RestaurantState {
  bool get isInitial => status == RestaurantStateStatus.initial;
  bool get isLoading => status == RestaurantStateStatus.loading;
  bool get isLoaded => status == RestaurantStateStatus.loaded;
  bool get isError => status == RestaurantStateStatus.error;
}

@immutable

class RestaurantState {
  final RestaurantStateStatus status;
  final String? errorMessage;

  const RestaurantState({
    this.status = RestaurantStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as RestaurantState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>  status.hashCode ^ errorMessage.hashCode;

  RestaurantState copyWith({
    RestaurantStateStatus? status,
    String? errorMessage,
  }) {
    return RestaurantState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}