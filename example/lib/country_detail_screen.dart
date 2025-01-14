import 'package:flutter/material.dart';
import 'models/country.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(country.name),
              background: Image.network(
                '${country.imageUrl}?auto=format&fit=crop&w=800&q=80',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        country.rating.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: () {
                          // TODO: Implement save action
                        },
                        icon: const Icon(Icons.bookmark_outline),
                        label: const Text('Save'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    country.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  context,
                  'Key Benefits',
                  country.benefits.entries.map((entry) => _buildBenefitTile(
                    context,
                    _getBenefitIcon(entry.key),
                    entry.key,
                    entry.value,
                  )).toList(),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  context,
                  'Resources',
                  country.resources.entries.map((entry) => _buildResourceTile(
                    context,
                    _getResourceIcon(entry.key),
                    entry.key,
                    entry.value,
                    () {
                      // TODO: Navigate to resource
                    },
                  )).toList(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilledButton(
            onPressed: () {
              // TODO: Implement get started action
            },
            child: const Text('Get Started'),
          ),
        ),
      ),
    );
  }

  IconData _getBenefitIcon(String benefit) {
    switch (benefit.toLowerCase()) {
      case 'tax benefits':
        return Icons.account_balance_outlined;
      case 'residency':
        return Icons.home_outlined;
      case 'business environment':
        return Icons.business_center_outlined;
      case 'digital infrastructure':
        return Icons.computer_outlined;
      case 'innovation':
        return Icons.lightbulb_outline;
      case 'quality of life':
        return Icons.emoji_emotions_outlined;
      case 'visa policy':
        return Icons.card_membership_outlined;
      case 'cost of living':
        return Icons.savings_outlined;
      default:
        return Icons.star_outline;
    }
  }

  IconData _getResourceIcon(String resource) {
    switch (resource.toLowerCase()) {
      case 'official documentation':
        return Icons.article_outlined;
      case 'local community':
        return Icons.people_outline;
      case 'support services':
        return Icons.support_agent_outlined;
      case 'e-residency':
        return Icons.badge_outlined;
      case 'startup estonia':
        return Icons.rocket_launch_outlined;
      case 'work in estonia':
        return Icons.work_outline;
      case 'business house':
        return Icons.store_outlined;
      case 'digital nomad hub':
        return Icons.laptop_mac_outlined;
      case 'investment guide':
        return Icons.trending_up_outlined;
      default:
        return Icons.link_outlined;
    }
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildBenefitTile(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
    );
  }

  Widget _buildResourceTile(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 