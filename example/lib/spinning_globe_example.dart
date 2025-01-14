import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_example/example.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_maps_example/main.dart';

class SpinningGlobeExample extends StatefulWidget implements Example {
  const SpinningGlobeExample({Key? key}) : super(key: key);

  @override
  final Widget leading = const Icon(Icons.threesixty_outlined);
  @override
  final String title = 'Spinning Globe';
  @override
  final String? subtitle = 'Display your map as an interactive, rotating globe.';

  @override
  State<StatefulWidget> createState() => SpinningGlobeExampleState();
}

class SpinningGlobeExampleState extends State<SpinningGlobeExample> with WidgetsBindingObserver {
  late final MapboxMap mapboxMap;
  late final StreamController<CameraOptions> cameras;
  StreamSubscription? subscription;
  var isSpinning = true;

  @override
  void initState() {
    super.initState();
    cameras = StreamController<CameraOptions>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resumeSpinning();
    }
  }

  void _resumeSpinning() async {
    if (!cameras.hasListener) {
      final cameraState = await mapboxMap.getCameraState();
      _spinGlobe(cameraState);
    }
  }

  void _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    if (!cameras.hasListener) {
      cameras.onListen = () async {
        _spinGlobe(await mapboxMap.getCameraState());
      };
    }
  }

  void _onStyleLoaded(_) {
    subscription = cameras.stream.listen((toCamera) async {
      await mapboxMap.easeTo(toCamera, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
        onMapCreated: _onMapCreated,
        onStyleLoadedListener: _onStyleLoaded,
        onCameraChangeListener: (data) {
          _spinGlobe(data.cameraState);
        },
      ),
    );
  }

  void _spinGlobe(CameraState camera) {
    final secondsPerRev = 120.0;
    final slowSpinZoom = 3.0;
    final maxSpinZoom = 5.0;

    if (camera.zoom < maxSpinZoom && !cameras.isClosed && !cameras.isPaused) {
      final speedFactor = (maxSpinZoom - max(slowSpinZoom, camera.zoom)) /
          (maxSpinZoom - slowSpinZoom);
      final distancePerSecond = speedFactor * 360.0 / secondsPerRev;

      final newCamera = CameraOptions(
        center: Point(
          coordinates: Position(
            camera.center.coordinates.lng - distancePerSecond,
            camera.center.coordinates.lat,
          ),
        ),
      );

      cameras.add(newCamera);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    subscription?.cancel();
    cameras.close();
    super.dispose();
  }
}
