import 'package:flutter/material.dart';

import 'package:mapas_app/custom_markers/custom_markers.dart';

class TestMarkerPage extends StatelessWidget {
  const TestMarkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerDestinoPainter(
              'Mi casa por algun lado del mundo aqwui, esta, asd dirteccion asd fg',
              25000,
            ),
          ),
        ),
      ),
    );
  }
}
