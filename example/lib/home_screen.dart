import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_example/spinning_globe_example.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: SpinningGlobeExample(),
    );
  }
} 