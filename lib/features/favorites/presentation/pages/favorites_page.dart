
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    super.key
  });
  static const routeName = '/FavoritesPage';


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Favorites'),
     ),
     body: const Center(
       child: Text('Favorites Page'),
     ),
   );
  }

}
