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
      child: Scaffold(
        body: Stack(
          children: [
            SpinningGlobeExample(),
            _buildBottomSheet(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      snapSizes: const [0.1, 0.5, 0.9],
      snap: true,
      snapAnimationDuration: const Duration(milliseconds: 400),
      controller: DraggableScrollableController(),
      builder: (BuildContext context, ScrollController scrollController) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutExpo,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Welcome to Exodus',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Your gateway to exploring the world',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: Text('Location ${index + 1}'),
                      subtitle: Text('Description for location ${index + 1}'),
                    );
                  },
                  childCount: 50,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 