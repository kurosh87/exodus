import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('Explore Destinations'),
          floating: true,
          pinned: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildListDelegate([
              _DestinationCard(
                country: 'Paraguay',
                imageUrl: 'https://source.unsplash.com/featured/?paraguay',
                description: 'Low tax rates & easy residency process',
                rating: 4.5,
              ),
              _DestinationCard(
                country: 'Uruguay',
                imageUrl: 'https://source.unsplash.com/featured/?uruguay',
                description: 'Stable economy & high quality of life',
                rating: 4.7,
              ),
              _DestinationCard(
                country: 'Mexico',
                imageUrl: 'https://source.unsplash.com/featured/?mexico',
                description: 'Rich culture & growing tech hub',
                rating: 4.3,
              ),
              _DestinationCard(
                country: 'Panama',
                imageUrl: 'https://source.unsplash.com/featured/?panama',
                description: 'Tax benefits & strategic location',
                rating: 4.4,
              ),
              _DestinationCard(
                country: 'Costa Rica',
                imageUrl: 'https://source.unsplash.com/featured/?costarica',
                description: 'Beautiful nature & peaceful living',
                rating: 4.6,
              ),
              _DestinationCard(
                country: 'Portugal',
                imageUrl: 'https://source.unsplash.com/featured/?portugal',
                description: 'EU access & digital nomad friendly',
                rating: 4.8,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String country;
  final String imageUrl;
  final String description;
  final double rating;

  const _DestinationCard({
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.rating,
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
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
                      Text(
                        country,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
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
                            rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
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