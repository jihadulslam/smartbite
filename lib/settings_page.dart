import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_page.dart'; // Ensure you import your Welcome page

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Color _primaryColor = const Color(0xFF7A232E);
  final Color _bgColor = const Color(0xFFFAF9F9);
  int _currentIndex = 4; // Profile tab is active[cite: 16]

  // Switch states[cite: 16]
  bool mealReminders = true;
  bool foodStories = false;
  bool offersPromotions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account & Preferences Section[cite: 16]
            _buildSectionHeader('ACCOUNT & PREFERENCES'),
            _buildListTile(Icons.person_outline, 'Account details', ''),
            _buildListTile(Icons.shield_outlined, 'Privacy & your data', ''),
            _buildListTile(Icons.translate, 'Language', 'English'),
            const SizedBox(height: 16),

            // Notifications Section[cite: 16]
            _buildSectionHeader('NOTIFICATIONS'),
            _buildSwitchTile(Icons.access_time, 'Meal reminders', mealReminders, (val) {
              setState(() => mealReminders = val);
            }),
            _buildSwitchTile(Icons.article_outlined, 'Food stories', foodStories, (val) {
              setState(() => foodStories = val);
            }),
            _buildSwitchTile(Icons.local_offer_outlined, 'Offers & promotions', offersPromotions, (val) {
              setState(() => offersPromotions = val);
            }),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Reminders at 8 AM, 1 PM and 7:30 PM.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(height: 16),

            // Other Settings[cite: 16]
            _buildListTile(Icons.help_outline, 'Help & support', ''),
            _buildListTile(Icons.info_outline, 'About SmartBite', 'v1.0'),
            const SizedBox(height: 32),

            // Log Out Button[cite: 16]
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    // Firebase Sign Out Logic
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomePage()),
                            (route) => false, // Removes all previous routes
                      );
                    }
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      color: _primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Footer Text[cite: 16]
            Center(
              child: Text(
                'Your kitchen preferences stay private.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar[cite: 16]
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst); // Go back to Home
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), activeIcon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), activeIcon: Icon(Icons.shopping_basket), label: 'Grocery'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), activeIcon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 12, color: _primaryColor, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String trailingText) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: _primaryColor),
      title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText.isNotEmpty)
            Text(trailingText, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 14, color: _primaryColor),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: _primaryColor),
      title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: _primaryColor,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.grey.shade300,
      ),
    );
  }
}