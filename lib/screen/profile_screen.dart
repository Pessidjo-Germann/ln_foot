import 'package:flutter/material.dart';
import 'package:ln_foot/screen/home_screen.dart';
import 'package:ln_foot/screen/my_orders_screen.dart';
import 'package:ln_foot/screen/notification_screen.dart'; // Added import

import 'package:ln_foot/screen/profile_details_screen.dart';
import 'package:ln_foot/screen/privacy_policy_screen.dart'; // Import PrivacyPolicyScreen
import 'package:ln_foot/widgets/common/logout_confirmation_dialog.dart';
import 'package:ln_foot/widgets/custom_app_bar.dart';
import 'package:ln_foot/widgets/profile/profile_menu_item.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Compte',
        showBackButton: true,
        onBackButtonPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons
                .notifications_none_outlined), // Or your custom notification icon
            onPressed: () {
              // TODO: Navigate to Notification Screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
          ),
          const SizedBox(width: 16), // Add some padding
        ],
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView if content might overflow
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          children: [
            // Profile Menu Items
            ProfileMenuItem(
              icon: Icons.person_outline,
              title: 'Votre Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileDetailsScreen()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.list_alt_outlined, // Using a suitable icon
              title: 'Ma commande',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyOrdersScreen()),
                );
                print('Navigate to Orders');
              },
            ),
            ProfileMenuItem(
              icon: Icons.notifications_none_outlined,
              title: 'Notifications',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.lock_outline,
              title: 'politique de confidentialité',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Centre d\'aide',
              onTap: () async {
                const phone = '678558841';
                final url = Uri.parse('https://wa.me/$phone');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Impossible d\'ouvrir WhatsApp.')),
                  );
                }
              },
            ),

            const SizedBox(height: 30), // Spacer before logout

            // Logout Button
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red, size: 24),
              title: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              onTap: () {
                showLogoutDialog(context);
                print('Logout tapped');
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
