// ─────────────────────────────────────────────
// TopBezierClipper
// ─────────────────────────────────────────────

import 'package:flutter/cupertino.dart';

class TopBezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double curveHeight = 80;

    return Path()
      ..moveTo(0, curveHeight)
      ..quadraticBezierTo(
        size.width / 2,
        curveHeight + 80,
        size.width,
        curveHeight,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}