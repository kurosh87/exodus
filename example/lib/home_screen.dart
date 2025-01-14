import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_example/spinning_globe_example.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _globeKey = GlobalKey<SpinningGlobeExampleState>();

  static const List<DestinationData> destinations = [
    DestinationData(
      country: 'Paraguay',
      imageUrl: 'https://images.unsplash.com/photo-1585974738771-84483dd9f89f',
      description: 'Low tax rates & easy residency process',
      rating: 4.5,
    ),
    DestinationData(
      country: 'Uruguay',
      imageUrl: 'https://images.unsplash.com/photo-1600623471616-8c1966c91ff6',
      description: 'Stable economy & high quality of life',
      rating: 4.7,
    ),
    DestinationData(
      country: 'Mexico',
      imageUrl: 'https://images.unsplash.com/photo-1518638150340-f706e86654de',
      description: 'Rich culture & growing tech hub',
      rating: 4.3,
    ),
    DestinationData(
      country: 'Panama',
      imageUrl: 'https://images.unsplash.com/photo-1554844344-c34ea04258c4',
      description: 'Tax benefits & strategic location',
      rating: 4.4,
    ),
    DestinationData(
      country: 'Costa Rica',
      imageUrl: 'https://images.unsplash.com/photo-1580094777767-4aa98cfa1c2f',
      description: 'Beautiful nature & peaceful living',
      rating: 4.6,
    ),
    DestinationData(
      country: 'Portugal',
      imageUrl: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b',
      description: 'EU access & digital nomad friendly',
      rating: 4.8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            VisibilityDetector(
              key: const Key('globe_detector'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 1) {
                  _globeKey.currentState?.mapboxMap.setGestureInProgress(true);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _globeKey.currentState?.mapboxMap.setGestureInProgress(false);
                  });
                }
              },
              child: SpinningGlobeExample(key: _globeKey),
            ),
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
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
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
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
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
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _DestinationCard(
                      destination: destinations[index],
                    ),
                    childCount: destinations.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100), // Bottom padding
              ),
            ],
          ),
        );
      },
    );
  }
}

class DestinationData {
  final String country;
  final String imageUrl;
  final String description;
  final double rating;

  const DestinationData({
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });
}

class _DestinationCard extends StatelessWidget {
  final DestinationData destination;

  const _DestinationCard({
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to country detail page
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                '${destination.imageUrl}?auto=format&fit=crop&w=400&q=80',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 32,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          destination.country,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            destination.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destination.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 