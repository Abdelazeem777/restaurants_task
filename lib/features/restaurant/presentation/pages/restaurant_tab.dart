import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_task/core/di/injector.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart'
    hide Icon, Center;
import 'package:restaurants_task/features/restaurant/presentation/cubits/restaurant_cubit/restaurant_cubit.dart';
import 'package:restaurants_task/features/restaurant/presentation/shared_widgets/search_text_form_field.dart';

import 'restaurant_details_page.dart';

class RestaurantTab extends StatefulWidget {
  const RestaurantTab({super.key});
  static const routeName = '/RestaurantTab';

  @override
  State<RestaurantTab> createState() => _RestaurantTabState();
}

class _RestaurantTabState extends State<RestaurantTab> {
  late final MapController _mapController;

  late final TextEditingController _currentController;
  late final FocusNode _currentFocusNode;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _currentController = TextEditingController();
    _currentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _mapController.dispose();

    _currentController.dispose();
    _currentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantCubit>(
      create: (context) => sl()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurant'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<RestaurantCubit, RestaurantState>(
      listener: (context, state) {
        if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
      },
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        if (state.isInitial || state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            _buildSearchBar(context),
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    state.currentLocation!.latitude,
                    state.currentLocation!.longitude,
                  ),
                  interactionOptions: const InteractionOptions(
                    flags: ~InteractiveFlag.doubleTapZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  _buildRestaurantsMarkers(state.restaurants ?? []),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRestaurantsMarkers(List<Place> restaurants) {
    return BlocBuilder<RestaurantCubit, RestaurantState>(
      builder: (context, state) {
        final list = restaurants
            .map(
              (restaurant) => Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                  restaurant.geocodes.main.latitude,
                  restaurant.geocodes.main.longitude,
                ),
                child: InkWell(
                  child: const Icon(
                    Icons.restaurant,
                    size: 40.0,
                    color: Colors.red,
                  ),
                  onTap: () => _goToRestaurantDetails(context, restaurant),
                ),
              ),
            )
            .toList();
        return MarkerLayer(
          markers: list,
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final cubit = context.read<RestaurantCubit>();
    return StreamedSearchTextField(
      currentFocusNode: _currentFocusNode,
      currentController: _currentController,
      onChanged: (text) => cubit.loadRestaurants(query: text),
    );
  }

  Future<void> _goToRestaurantDetails(
    BuildContext context,
    Place restaurant,
  ) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsPage(place: restaurant),
      ),
    );
  }
}
