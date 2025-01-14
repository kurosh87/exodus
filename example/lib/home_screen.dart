import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'spinning_globe_example.dart';
import 'models/country.dart';
import 'country_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<Map<String, String>> destinations = [
    {
      'title': 'Explore Countries',
      'subtitle': 'Discover new opportunities around the world',
      'icon': '🌍',
    },
    {
      'title': 'Digital Nomad Visas',
      'subtitle': 'Work remotely from anywhere',
      'icon': '💻',
    },
    {
      'title': 'Investment Programs',
      'subtitle': 'Secure your future through investment',
      'icon': '📈',
    },
    {
      'title': 'Tax Benefits',
      'subtitle': 'Optimize your global tax strategy',
      'icon': '💰',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            SpinningGlobeExample(),
            DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.15,
              maxChildSize: 0.8,
              snapSizes: const [0.15, 0.5, 0.8],
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 8, bottom: 16),
                                width: 32,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Welcome to Exodus',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Your journey to global citizenship begins here',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 140,
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                scrollDirection: Axis.horizontal,
                                itemCount: destinations.length,
                                itemBuilder: (context, index) {
                                  final destination = destinations[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    child: InkWell(
                                      onTap: () {
                                        // TODO: Navigate to specific section
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width: 160,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              destination['icon']!,
                                              style: const TextStyle(fontSize: 24),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              destination['title']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              destination['subtitle']!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Featured Countries',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final country = Country.sampleCountries[index];
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CountryDetailScreen(
                                          country: country,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          '${country.imageUrl}?auto=format&fit=crop&w=400&q=80',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceVariant,
                                              child: Center(
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  size: 32,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              country.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star_rounded,
                                                  size: 16,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  country.rating.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: Country.sampleCountries.length,
                          ),
                        ),
                      ),
                      const SliverPadding(
                        padding: EdgeInsets.only(bottom: 32),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 