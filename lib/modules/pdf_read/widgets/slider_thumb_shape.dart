import 'package:flutter/material.dart';

class SliderThumbShape extends SliderComponentShape {
  const SliderThumbShape({
    required this.thumbRadius,
    required this.thumbColor,
    this.thumbHeight = 20.0,
    this.thumbWidth = 30.0,
    this.rotationAngle = 90,
  });
  final double thumbRadius;
  final Color thumbColor;
  final double thumbHeight;
  final double thumbWidth;
  final int rotationAngle;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(rotationAngle * 3.1415927 / 180)
      ..translate(-center.dx, -center.dy);

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = thumbColor;

    // draw icon with text painter
    const iconData = Icons.drag_handle;
    final textPainter = TextPainter(textDirection: TextDirection.rtl)
      ..text = TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontSize: thumbRadius * 2,
          fontFamily: iconData.fontFamily,
          color: sliderTheme.thumbColor,
        ),
      )
      ..layout();

    final textCenter = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );
    const cornerRadius = 4.0;

    // draw the background shape here..
    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(
          center: center,
          width: thumbWidth,
          height: thumbHeight,
        ),
        cornerRadius,
        cornerRadius,
      ),
      paint,
    );

    textPainter.paint(canvas, textCenter);
  }
}
