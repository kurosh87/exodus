import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_example/animated_route_example.dart';
import 'package:mapbox_maps_example/animation_example.dart';
import 'package:mapbox_maps_example/camera_example.dart';
import 'package:mapbox_maps_example/circle_annotations_example.dart';
import 'package:mapbox_maps_example/cluster_example.dart';
import 'package:mapbox_maps_example/offline_map_example.dart';
import 'package:mapbox_maps_example/model_layer_example.dart';
import 'package:mapbox_maps_example/ornaments_example.dart';
import 'package:mapbox_maps_example/geojson_line_example.dart';
import 'package:mapbox_maps_example/image_source_example.dart';
import 'package:mapbox_maps_example/map_interface_example.dart';
import 'package:mapbox_maps_example/polygon_annotations_example.dart';
import 'package:mapbox_maps_example/polyline_annotations_example.dart';
import 'package:mapbox_maps_example/simple_map_example.dart';
import 'package:mapbox_maps_example/snapshotter_example.dart';
import 'package:mapbox_maps_example/spinning_globe_example.dart';
import 'package:mapbox_maps_example/traffic_route_line_example.dart';
import 'package:mapbox_maps_example/tile_json_example.dart';
import 'package:mapbox_maps_example/vector_tile_source_example.dart';
import 'package:mapbox_maps_example/viewport_example.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'full_map_example.dart';
import 'location_example.dart';
import 'example.dart';
import 'point_annotations_example.dart';
import 'projection_example.dart';
import 'style_example.dart';
import 'gestures_example.dart';
import 'debug_options_example.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

final List<Example> _allPages = <Example>[
  SimpleMapExample(),
  ViewportExample(),
  SnapshotterExample(),
  TrafficRouteLineExample(),
  OfflineMapExample(),
  ModelLayerExample(),
  DebugOptionsExample(),
  SpinningGlobeExample(),
  FullMapExample(),
  StyleExample(),
  CameraExample(),
  ProjectionExample(),
  MapInterfaceExample(),
  StyleClustersExample(),
  AnimationExample(),
  PointAnnotationExample(),
  CircleAnnotationExample(),
  PolylineAnnotationExample(),
  PolygonAnnotationExample(),
  VectorTileSourceExample(),
  DrawGeoJsonLineExample(),
  ImageSourceExample(),
  TileJsonExample(),
  LocationExample(),
  GesturesExample(),
  OrnamentsExample(),
  AnimatedRouteExample(),
];

class MapsDemo extends StatefulWidget {
  static const String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN",
      defaultValue: 'pk.eyJ1IjoicmVhbGVzdGF0ZWJvdCIsImEiOiJjbTMzM2d5dWoxOXhlMmlzNG01YmgwY2x1In0.yv0Nac7EjmWZvjg40KS6nw');

  @override
  _MapsDemoState createState() => _MapsDemoState();
}

class _MapsDemoState extends State<MapsDemo> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _pushPage(BuildContext context, Example page) async {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  Widget _buildExamplesContent() {
    return MapsDemo.ACCESS_TOKEN.isEmpty || MapsDemo.ACCESS_TOKEN.contains("YOUR_TOKEN")
        ? buildAccessTokenWarning()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Developer Reference',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _allPages.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, int index) {
                    final example = _allPages[index];
                    return ListTile(
                      leading: example.leading,
                      title: Text(example.title),
                      subtitle: (example.subtitle?.isNotEmpty == true)
                          ? Text(
                              example.subtitle!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      onTap: () => _pushPage(context, _allPages[index]),
                    );
                  },
                ),
              ),
            ],
          );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Center(child: Text('Examples'));
      case 2:
        return Center(child: Text('Favorites'));
      case 3:
        return SettingsScreen(
          mapExamples: _allPages,
          isDarkMode: _isDarkMode,
          onThemeToggle: toggleTheme,
        );
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            _buildBody(),
            if (_selectedIndex == 0)
              Positioned(
                top: 60,
                left: 16,
                child: SvgPicture.asset(
                  'assets/images/exodus_logo.svg',
                  height: 30,
                  color: _isDarkMode ? Colors.white : null,
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Examples',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget buildAccessTokenWarning() {
    return Container(
      color: Colors.red[900],
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Please pass in your access token with",
            "--dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE",
            "passed into flutter run or add it to args in vscode's launch.json",
          ]
              .map((text) => Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken(MapsDemo.ACCESS_TOKEN);
  
  runApp(MapsDemo());
}
