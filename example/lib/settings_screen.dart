import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _handleThemeChange(BuildContext context, bool value) {
    Provider.of<ThemeProvider>(context, listen: false).setThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Settings'),
          floating: true,
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _buildSection(
              context,
              'Account',
              [
                _SettingsItem(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {
                    // TODO: Navigate to profile
                  },
                ),
                _SettingsItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {
                    // TODO: Navigate to notifications
                  },
                ),
                _SettingsItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {
                    // TODO: Show language picker
                  },
                ),
              ],
            ),
            _buildSection(
              context,
              'App Settings',
              [
                _SettingsItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) => _handleThemeChange(context, value),
                  ),
                  onTap: () => _handleThemeChange(context, !isDarkMode),
                ),
                _SettingsItem(
                  icon: Icons.location_on_outlined,
                  title: 'Location Services',
                  onTap: () {
                    // TODO: Navigate to location settings
                  },
                ),
                _SettingsItem(
                  icon: Icons.security_outlined,
                  title: 'Privacy & Security',
                  onTap: () {
                    // TODO: Navigate to privacy settings
                  },
                ),
              ],
            ),
            _buildSection(
              context,
              'Support',
              [
                _SettingsItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {
                    // TODO: Navigate to help center
                  },
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    // TODO: Show about dialog
                  },
                ),
                _SettingsItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  textColor: Theme.of(context).colorScheme.error,
                  onTap: () {
                    // TODO: Handle sign out
                  },
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
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
        ...items,
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? textColor;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: textColor != null
            ? TextStyle(color: textColor)
            : null,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
} 