import 'package:flutter/material.dart';
import 'package:restaurants_task/features/restaurant/data/models/place_model.dart'
    hide Center, Icon;

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({
    super.key,
    required this.place,
  });
  static const routeName = '/RestaurantDetailsPage';

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: Center(
        child: Text(place.name),
      ),
    );
  }
}
