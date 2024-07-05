
import 'package:flutter/material.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({
    super.key
  });
  static const routeName = '/RestaurantPage';


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Restaurant'),
     ),
     body: const Center(
       child: Text('Restaurant Page'),
     ),
   );
  }

}
