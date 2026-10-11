import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/profile_store.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    ProfileStore.read().then((profile) {
      if (!mounted) return;
      _name.text = profile['name'] ?? '';
      _email.text = profile['email'] ?? '';
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await ProfileStore.save(name: _name.text.trim(), email: _email.text.trim());
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Edit profile')),
    body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Full name',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Enter your name'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email address',
              border: OutlineInputBorder(),
            ),
            validator: (value) => value != null && value.contains('@')
                ? null
                : 'Enter a valid email',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: FilledButton(
              onPressed: _save,
              child: const Text('Save profile'),
            ),
          ),
        ],
      ),
    ),
  );
}

class GiftCardsPage extends StatefulWidget {
  const GiftCardsPage({super.key});

  @override
  State<GiftCardsPage> createState() => _GiftCardsPageState();
}

class _GiftCardsPageState extends State<GiftCardsPage> {
  bool _upiSaved = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Gift cards & wallet')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Wallet balance'),
            subtitle: const Text('₹0 available'),
            trailing: TextButton(
              onPressed: () => _showRedeem(context),
              child: const Text('Redeem'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Gift cards',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.card_giftcard_outlined),
            title: const Text('Add a gift card'),
            subtitle: const Text('Redeem a code and use it at checkout'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showRedeem(context),
          ),
        ),
        const SizedBox(height: 16),
        _banner('Gift Cards for all Occasions', Icons.card_giftcard),
        _banner('Manara Axis Bank Credit Card', Icons.credit_card),
        const SizedBox(height: 16),
        const Text(
          'Saved Cards',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const Text('Save your Credit/Debit cards for faster payments.'),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () => _message('New card form opened'),
          icon: const Icon(Icons.add_card),
          label: const Text('Add New Card'),
        ),
        const SizedBox(height: 16),
        const Text(
          'UPI',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        ListTile(
          leading: const Icon(Icons.account_balance_wallet_outlined),
          title: Text(_upiSaved ? 'manara@upi' : 'No VPAs saved to be shown'),
          trailing: TextButton(
            onPressed: () => setState(() => _upiSaved = true),
            child: const Text('Add UPI'),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('View transaction history'),
          onTap: () => _message('Transaction history opened'),
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Help'),
          onTap: () => context.push('/account/faqs'),
        ),
      ],
    ),
  );

  void _showRedeem(BuildContext context) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Redeem gift card'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter gift card code',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              dialogContext.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gift card code submitted')),
              );
            },
            child: const Text('Redeem'),
          ),
        ],
      ),
    );
  }

  Widget _banner(String title, IconData icon) => Card(
    color: const Color(0xFF2874F0),
    child: ListTile(
      leading: Icon(icon, color: Colors.white, size: 30),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
    ),
  );

  void _message(String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
}
