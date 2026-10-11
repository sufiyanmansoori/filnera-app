import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/services/profile_store.dart';
import '../../../../features/account/presentation/pages/account_support_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, String>> _profile;
  String _language = 'English';

  @override
  void initState() {
    super.initState();
    _profile = ProfileStore.read();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder<Map<String, String>>(
      future: _profile,
      builder: (context, snapshot) {
        final profile = snapshot.data;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
          children: [
            _profileHeader(profile),
            const SizedBox(height: 16),
            _heading('Recently Viewed Stores'),
            _recentlyViewed(),
            const SizedBox(height: 14),
            Card(
              color: Colors.deepPurple.shade50,
              child: ListTile(
                leading: const Icon(
                  Icons.local_activity_outlined,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Explore and grab the best deals',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/deals'),
              ),
            ),
            _tile(
              Icons.chat_bubble_outline,
              'Questions & Answers',
              () => context.push('/account/faqs'),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _statTile('Orders', '24'),
                const SizedBox(width: 10),
                _statTile('Wishlist', '12'),
                const SizedBox(width: 10),
                _statTile('Rewards', '1.2k'),
              ],
            ),
            const SizedBox(height: 22),
            _heading('Business, Selling & Verification'),
            _tile(
              Icons.campaign_outlined,
              'Manara Affiliate Program',
              () => context.push('/account/business'),
            ),
            _tile(
              Icons.inventory_2_outlined,
              'Bulk Purchasing (B2B)',
              () => context.push('/account/business'),
            ),
            _tile(
              Icons.storefront_outlined,
              'Sell on Manara',
              () => context.push('/account/business'),
            ),
            const SizedBox(height: 18),
            _heading('Help & Legal'),
            _tile(
              Icons.edit_outlined,
              'Edit Profile',
              () => context.push('/edit-profile'),
            ),
            _tile(
              Icons.help_outline,
              'FAQs',
              () => context.push('/account/faqs'),
            ),
            _tile(
              Icons.policy_outlined,
              'Terms, Policies & Licences',
              () => context.push('/account/policies'),
            ),
            _tile(
              Icons.receipt_long_outlined,
              'My Orders',
              () => context.push('/orders'),
            ),
            _tile(
              Icons.location_on_outlined,
              'Delivery addresses',
              () => context.push('/addresses'),
            ),
            _tile(
              Icons.settings_outlined,
              'Settings',
              () => context.push('/settings'),
            ),
            _tile(
              Icons.card_giftcard_outlined,
              'Gift Cards & Wallet',
              () => context.push('/gift-cards'),
            ),
            _tile(
              Icons.credit_card_outlined,
              'Saved Payment Methods',
              () => context.push('/saved-payments'),
            ),
            _tileWithTrailing(
              Icons.language,
              'Change Language',
              Chip(
                label: Text(_language),
                visualDensity: VisualDensity.compact,
              ),
              _chooseLanguage,
            ),
            _tileWithTrailing(
              Icons.notifications_none,
              'Notification Settings',
              Switch(value: true, onChanged: (_) => context.push('/settings')),
              () => context.push('/settings'),
            ),
            const SizedBox(height: 18),
            _heading('Security & Privacy'),
            _tile(
              Icons.shield_outlined,
              'Privacy Center',
              () => context.push('/privacy-center'),
            ),
            _tileWithTrailing(
              Icons.devices_outlined,
              'Manage Devices',
              const Chip(
                label: Text('3 active devices'),
                backgroundColor: Color(0xFFE8F1FF),
                labelStyle: TextStyle(color: Color(0xFF1557A6)),
                visualDensity: VisualDensity.compact,
              ),
              () => context.push('/manage-devices'),
            ),
            const SizedBox(height: 18),
            _heading('Follow Us On'),
            _social(
              Icons.camera_alt_outlined,
              'Instagram',
              'https://www.instagram.com/',
            ),
            _social(
              Icons.play_circle_outline,
              'YouTube',
              'https://www.youtube.com/',
            ),
            _social(
              Icons.business_center_outlined,
              'LinkedIn',
              'https://www.linkedin.com/',
            ),
            const SizedBox(height: 18),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log out'),
              onTap: () => _logout(context),
            ),
            const Center(
              child: Text('v1.0.0+1', style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Trusted by 50 Cr+ Indians',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    ),
  );

  Widget _profileHeader(Map<String, String>? profile) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.orange.shade100,
            child: Image.asset(AppAssets.logo, width: 46, height: 46),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile?['name'] ?? 'Loading profile...',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  profile?['email'] ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _heading(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
    ),
  );

  Widget _tile(IconData icon, String title, VoidCallback onTap) => Card(
    margin: const EdgeInsets.only(bottom: 6),
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );

  Widget _tileWithTrailing(
    IconData icon,
    String title,
    Widget trailing,
    VoidCallback onTap,
  ) => Card(
    margin: const EdgeInsets.only(bottom: 6),
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [trailing, const Icon(Icons.chevron_right)],
      ),
      onTap: onTap,
    ),
  );

  Widget _recentlyViewed() => SizedBox(
    height: 128,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        _RecentStore(
          title: 'Plain Cases',
          icon: Icons.phone_android,
          color: Colors.indigo,
        ),
        _RecentStore(
          title: 'Mobile Store',
          icon: Icons.smartphone,
          color: Colors.blue,
        ),
        _RecentStore(
          title: 'Fashion Hub',
          icon: Icons.checkroom,
          color: Colors.pink,
        ),
        _RecentStore(
          title: 'Home Decor',
          icon: Icons.home_work_outlined,
          color: Colors.teal,
        ),
      ],
    ),
  );

  Future<void> _chooseLanguage() async {
    final language = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in ['English', 'Hindi', 'Urdu'])
              ListTile(
                title: Text(item),
                trailing: item == _language ? const Icon(Icons.check) : null,
                onTap: () => context.pop(item),
              ),
          ],
        ),
      ),
    );
    if (language != null) setState(() => _language = language);
  }

  Widget _social(IconData icon, String label, String url) => ListTile(
    leading: Icon(icon),
    title: Text(label),
    trailing: const Icon(Icons.open_in_new, size: 18),
    onTap: () => openSocialLink(context, label, url),
  );

  Widget _statTile(String label, String value) => Expanded(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    ),
  );

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You can sign in again anytime.'),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => dialogContext.pop(true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) context.go('/login');
  }
}

class _RecentStore extends StatelessWidget {
  const _RecentStore({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 112,
    margin: const EdgeInsets.only(right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 82,
            width: 112,
            color: color.withValues(alpha: .15),
            child: Icon(icon, color: color, size: 42),
          ),
        ),
        const SizedBox(height: 5),
        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
    ),
  );
}
