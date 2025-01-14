import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Services'),
          floating: true,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const _ServiceCategory(
              title: 'Legal & Immigration',
              services: [
                _Service(
                  icon: Icons.gavel,
                  title: 'Residency Application',
                  description: 'Expert assistance with residency permits and visas',
                  price: '\$499',
                ),
                _Service(
                  icon: Icons.description,
                  title: 'Document Translation',
                  description: 'Professional translation of official documents',
                  price: '\$99',
                ),
              ],
            ),
            const _ServiceCategory(
              title: 'Real Estate',
              services: [
                _Service(
                  icon: Icons.home,
                  title: 'Property Search',
                  description: 'Personalized property hunting and viewings',
                  price: '\$299',
                ),
                _Service(
                  icon: Icons.apartment,
                  title: 'Rental Assistance',
                  description: 'Help finding and securing rental properties',
                  price: '\$199',
                ),
              ],
            ),
            const _ServiceCategory(
              title: 'Financial Services',
              services: [
                _Service(
                  icon: Icons.account_balance,
                  title: 'Bank Account Setup',
                  description: 'Assistance opening local bank accounts',
                  price: '\$149',
                ),
                _Service(
                  icon: Icons.calculate,
                  title: 'Tax Consultation',
                  description: 'Expert advice on tax implications and planning',
                  price: '\$399',
                ),
              ],
            ),
            const _ServiceCategory(
              title: 'Relocation Support',
              services: [
                _Service(
                  icon: Icons.local_shipping,
                  title: 'Moving Services',
                  description: 'International shipping and moving assistance',
                  price: 'Custom',
                ),
                _Service(
                  icon: Icons.school,
                  title: 'School Search',
                  description: 'Help finding and applying to schools',
                  price: '\$249',
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}

class _ServiceCategory extends StatelessWidget {
  final String title;
  final List<_Service> services;

  const _ServiceCategory({
    required this.title,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...services,
      ],
    );
  }
}

class _Service extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String price;

  const _Service({
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to service detail page
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'From',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 