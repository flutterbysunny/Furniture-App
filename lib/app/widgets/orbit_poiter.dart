// ─────────────────────────────────────────────
// OrbitPainter
// ─────────────────────────────────────────────

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height * 0.55,
      ),
    );

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-0.3);
    canvas.translate(-size.width / 2, -size.height / 2);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}