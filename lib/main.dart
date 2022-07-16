import 'package:flutter/material.dart';
// import 'dart:math' as math;

// void main() => runApp(MyApp());

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text(
          "APP",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "My first app",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  ));
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Custom Painter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DrawingPage(),
//     );
//   }
// }

// class DrawingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Lines'),
//       ),
//       body: CustomPaint(
//         painter: CurvePainter(),
//         foregroundPainter: ForegroundPainter(),
//         child: Container(),
//       ),
//     );
//   }
// }

// class DrawingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Center(
//         child: ClipPath(
//           clipper: MyCustomClipper(), // <--
//           child: Container(
//             width: 200,
//             height: 200,
//             color: Colors.pink,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyCustomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // This variable define for better understanding you can direct specify value in quadraticBezierTo method
//     var controlPoint = Offset(size.width / 2, size.height / 2);
//     var endPoint = Offset(size.width, size.height);

//     Path path = Path()
//       ..moveTo(size.width / 2, 0)
//       ..lineTo(0, size.height)
//       ..quadraticBezierTo(
//           controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
//       ..close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();

//     paint.color = Colors.lightBlue;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 3;

//     var startPoint = Offset(0, size.height / 2);
//     var controlPoint1 = Offset(size.width / 4, size.height / 3);
//     var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
//     var endPoint = Offset(size.width, size.height / 2);

//     var path = Path();
//     path.moveTo(startPoint.dx, startPoint.dy);
//     path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//         controlPoint2.dy, endPoint.dx, endPoint.dy);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class ForegroundPainter extends CustomPainter {
//   var sides = 3;
//   var radius = 100;
//   var radians = 0;

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.teal
//       ..strokeWidth = 5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     var path = Path();
//     var angle = (math.pi * 2) / sides;

//     Offset center = Offset(size.width / 2, size.height / 2);

// // startPoint => (100.0, 0.0)
//     Offset startPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));

//     path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

//     for (int i = 1; i <= sides; i++) {
//       double x = radius * math.cos(angle * i) + center.dx;
//       double y = radius * math.sin(angle * i) + center.dy;
//       path.lineTo(x, y);
//     }
//     path.close();
//     // canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
