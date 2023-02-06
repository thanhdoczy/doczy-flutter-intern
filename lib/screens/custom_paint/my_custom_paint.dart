import 'package:flutter/material.dart';

class MyCustomPaintScreen extends StatelessWidget {
  const MyCustomPaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomPaint(
          foregroundPainter: RectanglePainter(),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * 1 / 6, size.height * 1 / 2),
        Offset(size.width * 5 / 6, size.height * 1 / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // for screen
    final paint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    var a = Offset(size.width * 1 / 4, size.height * 1 / 4);
    var b = Offset(size.width * 3 / 4, size.height * 3 / 4);
    final rect = Rect.fromPoints(a, b);

    // canvas.drawRect(rect, paint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(32)), paint);

    // for topbar
    final paint2 = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;
    a = Offset(size.width * 1 / 4 + 40, size.height * 1 / 4);
    b = Offset(size.width * 3 / 4 - 40, size.height * 1 / 4 + 25);
    final rect2 = Rect.fromPoints(a, b);
    canvas.drawRRect(
        RRect.fromRectAndCorners(rect2,
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        paint2);

    // for bottombar
    final paint3 = Paint()
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    a = Offset(size.width * 1 / 4 + 45, size.height * 3 / 4 - 20);
    b = Offset(size.width * 3 / 4 - 45, size.height * 3 / 4 - 20);
    canvas.drawLine(a, b, paint3);

    // for camera & mic in topbar
    final paint4 = Paint()
      ..strokeWidth = 4
      ..color = Colors.white
      ..strokeCap = StrokeCap.round;

    a = Offset(size.width * 1 / 4 + 80, size.height * 1 / 4 + 10);
    b = Offset(size.width * 3 / 4 - 80, size.height * 1 / 4 + 10);
    canvas.drawLine(a, b, paint4);

    final paint5 = Paint()
      ..strokeWidth = 4
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width * 1 / 4 + 120, size.height * 1 / 4 + 10),
        2.5,
        paint5);

    // for sidebutton
    final paint6 = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    a = Offset(size.width * 1 / 4 - 5, size.height * 1 / 4 + 80);
    b = Offset(size.width * 1 / 4 - 5, size.height * 1 / 4 + 110);
    canvas.drawLine(a, b, paint6);

    final paint7 = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    a = Offset(size.width * 1 / 4 - 6, size.height * 1 / 4 + 120);
    b = Offset(size.width * 1 / 4 - 6, size.height * 1 / 4 + 150);
    canvas.drawLine(a, b, paint7);

    final paint8 = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    a = Offset(size.width * 3 / 4 + 6, size.height * 1 / 4 + 90);
    b = Offset(size.width * 3 / 4 + 6, size.height * 1 / 4 + 140);
    canvas.drawLine(a, b, paint8);

    final paint9 = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    a = Offset(size.width * 1 / 4 - 6, size.height * 1 / 4 + 40);
    b = Offset(size.width * 1 / 4 - 6, size.height * 1 / 4 + 60);
    canvas.drawLine(a, b, paint9);

    // illuminati inside the phone
    final paint10 = Paint()
      ..strokeWidth = 10
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 1 / 2, size.height * 1 / 4 + 100);
    path.lineTo(size.width * 1 / 4 + 20, size.height * 3 / 4 - 180);
    path.lineTo(size.width * 3 / 4 - 20, size.height * 3 / 4 - 180);
    path.close();
    canvas.drawPath(path, paint10);

    final paint11 = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final arc1 = Path();
    arc1.moveTo(size.width * 1 / 4 + 62, size.height * 1 / 2 - 30);
    arc1.arcToPoint(Offset(size.width * 3 / 4 - 62, size.height * 1 / 2 - 30),
        radius: Radius.circular(80));

    canvas.drawPath(arc1, paint11);
    final arc2 = Path();
    arc2.moveTo(size.width * 1 / 4 + 62, size.height * 1 / 2 - 25);
    arc2.arcToPoint(Offset(size.width * 3 / 4 - 62, size.height * 1 / 2 - 25),
        radius: Radius.circular(50), clockwise: false);

    canvas.drawPath(arc2, paint11);

    final paint12 = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(size.width * 1 / 2, size.height * 1 / 2 - 27.5), 7, paint12);

    final paint13 = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width * 1 / 2, size.height * 1 / 2 - 27.5), 2, paint13);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.amber
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 1 / 2, size.height * 1 / 4);
    path.lineTo(size.width * 1 / 6, size.height * 3 / 4);
    path.lineTo(size.width * 5 / 6, size.height * 3 / 4);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final arc1 = Path();
    arc1.moveTo(size.width * 1 / 4, size.height * 1 / 4);
    arc1.arcToPoint(Offset(size.width * 3 / 4, size.height * 1 / 4),
        radius: Radius.circular(140));

    canvas.drawPath(arc1, paint);
    final arc2 = Path();
    arc2.moveTo(size.width * 1 / 4, size.height * 1 / 4 + 10);
    arc2.arcToPoint(Offset(size.width * 3 / 4, size.height * 1 / 4 + 10),
        radius: Radius.circular(120), clockwise: false);

    canvas.drawPath(arc2, paint);

    final paint2 = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
        Offset(size.width * 1 / 2, size.height * 1 / 4 + 5), 20, paint2);

    final paint3 = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width * 1 / 2, size.height * 1 / 4 + 5), 5, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
