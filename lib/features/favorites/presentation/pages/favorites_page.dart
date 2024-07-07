import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_task/core/di/injector.dart';
import 'package:restaurants_task/features/favorites/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart'
    hide Center, Icon;
import 'package:restaurants_task/shared_widget/empty_page.dart';

import '../../../restaurant/presentation/pages/restaurant_details_page.dart';
import '../shared_widgets/favorite_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  static const routeName = '/FavoritesPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesCubit>(
      create: (context) => sl(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state.isError)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      builder: (context, state) {
        if (state.isLoading || state.isInitial)
          return const CircularProgressIndicator();

        final cubit = context.read<FavoritesCubit>();

        final favorites = state.favorites;
        if (favorites == null || favorites.isEmpty)
          return EmptyPage(
            message: state.errorMessage!,
            onRefresh: cubit.refresh,
          );

        return RefreshIndicator(
          onRefresh: cubit.refresh,
          child: ListView.builder(
            itemCount: state.favorites!.length,
            itemBuilder: (context, index) {
              final place = state.favorites![index];
              return FavoriteCard(
                key: ValueKey(place.fsqId),
                place: place,
                onTap: () => _goToRestaurantDetails(context, place),
                onAdd: () => cubit.addFavorite(place),
                onRemove: () => cubit.removeFavorite(place),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _goToRestaurantDetails(BuildContext context, Place place) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsPage(place: place),
      ),
    );
  }
}
