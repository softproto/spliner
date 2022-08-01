import 'dart:ui';

import 'package:flutter/material.dart';
// import 'dart:math' as math;

void main() => runApp(
      const MaterialApp(
        home: AnimatedPathDemo(),
      ),
    );

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> _animation;

  AnimatedPathPainter(this._animation) : super(repaint: _animation);

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(size.height / 4, size.height / 4)
      ..lineTo(size.height, size.width / 2)
      ..lineTo(size.height / 2, size.width)
      ..quadraticBezierTo(size.height / 2, 100, size.width, size.height)
      ..lineTo(size.height / 2, size.width / 2)
      ..quadraticBezierTo(200, 200, 100, 300);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = _animation.value;

    // print("Painting + $animationPercent - $size");

    final path = createAnimatedPath(_createAnyPath(size), animationPercent);

    final Paint paint = Paint();
    paint.color = Colors.amberAccent;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10.0;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedPathDemo extends StatefulWidget {
  const AnimatedPathDemo({Key? key}) : super(key: key);

  @override
  _AnimatedPathDemoState createState() => _AnimatedPathDemoState();
}

class _AnimatedPathDemoState extends State<AnimatedPathDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Paint')),
      body: SizedBox(
        height: 300,
        width: 300,
        child: CustomPaint(
          painter: AnimatedPathPainter(_controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startAnimation,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

Path createAnimatedPath(
  Path originalPath,
  double animationPercent,
) {
  // ComputeMetrics can only be iterated once!
  final totalLength = originalPath
      .computeMetrics()
      .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

  final currentLength = totalLength * animationPercent;

  return extractPathUntilLength(originalPath, currentLength);
}

Path extractPathUntilLength(
  Path originalPath,
  double length,
) {
  var currentLength = 0.0;

  final path = Path();

  var metricsIterator = originalPath.computeMetrics().iterator;

  while (metricsIterator.moveNext()) {
    var metric = metricsIterator.current;

    var nextLength = currentLength + metric.length;

    final isLastSegment = nextLength > length;
    if (isLastSegment) {
      final remainingLength = length - currentLength;
      final pathSegment = metric.extractPath(0.0, remainingLength);

      path.addPath(pathSegment, Offset.zero);
      break;
    } else {
      // There might be a more efficient way of extracting an entire path
      final pathSegment = metric.extractPath(0.0, metric.length);
      path.addPath(pathSegment, Offset.zero);
    }

    currentLength = nextLength;
  }

  return path;
}




// void main() => runApp(MyApp());

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       backgroundColor: Colors.indigo,
//       appBar: AppBar(
//         title: const Text(
//           "APP",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           "My first app",
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     ),
//   ));
// }

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
