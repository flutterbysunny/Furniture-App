import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarRow extends StatelessWidget {
  final double rating;
  final double size;

  const StarRow({required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return Icon(Icons.star_rounded, color: Colors.orange, size: size);
        } else if (i < rating) {
          return Icon(Icons.star_half_rounded, color: Colors.orange, size: size);
        } else {
          return Icon(Icons.star_outline_rounded,
              color: Colors.orange.withOpacity(0.4), size: size);
        }
      }),
    );
  }
}
