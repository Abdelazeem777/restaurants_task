import 'package:flutter/material.dart';

import '../../../restaurant/data/models/place_model.dart' hide Center, Icon;

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({
    super.key,
    required this.place,
    required this.onAdd,
    required this.onRemove,
    required this.onTap,
  });

  final Place place;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  @override
  State<FavoriteCard> createState() => FavoriteCardState();
}

class FavoriteCardState extends State<FavoriteCard> {
  bool _isFavorite = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ListTile(
        title: Text(widget.place.name),
        trailing: IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
              _isFavorite ? widget.onAdd() : widget.onRemove();
            });
          },
        ),
      ),
    );
  }
}
