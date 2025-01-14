import 'package:flutter/material.dart';
import 'developer_screen.dart';
import 'example.dart';

class SettingsScreen extends StatelessWidget {
  final List<Example> mapExamples;
  final bool isDarkMode;
  final Function() onThemeToggle;

  const SettingsScreen({
    Key? key, 
    required this.mapExamples,
    required this.isDarkMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Account',
            items: [
              SettingsItem(
                icon: Icons.person_outline,
                title: 'Profile',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
            ],
          ),
          _buildSection(
            title: 'App Settings',
            items: [
              SettingsItem(
                icon: Icons.language,
                title: 'Language',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (_) => onThemeToggle(),
                ),
                onTap: onThemeToggle,
              ),
            ],
          ),
          _buildSection(
            title: 'Support',
            items: [
              SettingsItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {},
              ),
              SettingsItem(
                icon: Icons.bug_report_outlined,
                title: 'Developer Options',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeveloperScreen(mapExamples: mapExamples),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<SettingsItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        ...items,
        const SizedBox(height: 16),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingsItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
} 