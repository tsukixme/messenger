// SPDX-FileCopyrightText: 2026 Contributors to Tildes
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:material_ui/material_ui.dart';

/// The same vector mark as the Android launcher, without a raster dependency.
class TildesMark extends StatelessWidget {
  final double size;

  const TildesMark({super.key, this.size = 108});

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: const _TildesMarkPainter()),
    ),
  );
}

class _TildesMarkPainter extends CustomPainter {
  const _TildesMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 108, size.height / 108);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 108, 108),
        const Radius.circular(28),
      ),
      Paint()..color = const Color(0xFF334420),
    );
    final outline = Paint()
      ..color = const Color(0xFFD9B96E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(
      Path()
        ..moveTo(40, 30)
        ..lineTo(68, 30)
        ..quadraticBezierTo(80, 30, 80, 42)
        ..lineTo(80, 64)
        ..quadraticBezierTo(80, 76, 68, 76)
        ..lineTo(49, 76)
        ..lineTo(39, 80)
        ..lineTo(39, 76)
        ..quadraticBezierTo(28, 75, 28, 64)
        ..lineTo(28, 42)
        ..quadraticBezierTo(28, 30, 40, 30),
      outline,
    );
    outline.strokeWidth = 4.5;
    for (final y in [46.0, 60.0]) {
      canvas.drawPath(
        Path()
          ..moveTo(38, y)
          ..cubicTo(48, y - 9, 57, y + 9, 70, y),
        outline,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TildesMarkPainter oldDelegate) => false;
}
