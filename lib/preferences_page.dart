import 'package:flutter/material.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final Color _primaryColor = const Color(0xFF7A232E);
  final Color _chipInactiveBg = const Color(0xFFF9EBEC); // Light pinkish/maroon
  final Color _greenText = const Color(0xFF2E7D32);
  final Color _greenBg = const Color(0xFFE8F5E9);

  // State for selected chips to match the screenshot[cite: 11]
  final Set<String> _selectedFoodPrefs = {'Fish & chicken', 'Local flavours', 'Quick meals'};
  final Set<String> _selectedHealthConds = {'Diabetes'};
  final Set<String> _selectedDietTags = {'Diabetic Friendly', 'Low Sugar'};
  final Set<String> _selectedRoutines = {'Early start', 'Cook in 30 min'};

  // State for dropdown[cite: 11]
  String _selectedProfession = 'School teacher';
  final List<String> _professions = ['School teacher', 'Doctor', 'Engineer', 'Student', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9), // Off-white background
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        title: const Text(
          'Made for you',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
        // If you want a back button, Flutter adds it automatically if navigated via push
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator Section[cite: 11]
              Text(
                'YOUR KITCHEN • STEP 2 OF 2',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _primaryColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Headers[cite: 11]
              const Text(
                'Good food, your way.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tell us what fits your taste and everyday life.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),

              // Food Preferences[cite: 11]
              const Text(
                'Food preferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildChip('Fish & chicken', _selectedFoodPrefs),
                  _buildChip('Vegetarian', _selectedFoodPrefs),
                  _buildChip('Mild spice', _selectedFoodPrefs),
                  _buildChip('Local flavours', _selectedFoodPrefs),
                  _buildChip('Quick meals', _selectedFoodPrefs),
                ],
              ),
              const SizedBox(height: 24),

              // Health Conditions Card[cite: 11]
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Health conditions • optional',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildChip('Diabetes', _selectedHealthConds),
                        _buildChip('Hypertension', _selectedHealthConds),
                        _buildChip('None', _selectedHealthConds),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Green Diet Tags[cite: 11]
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildGreenChip('Diabetic Friendly', _selectedDietTags),
                        _buildGreenChip('Low Sugar', _selectedDietTags),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Preferences guide recipe suggestions, not medical advice. You can skip or change these anytime.',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Profession Dropdown[cite: 11]
              const Text(
                'Profession',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedProfession,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: _primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _professions.map((String profession) {
                  return DropdownMenuItem<String>(
                    value: profession,
                    child: Text(profession, style: const TextStyle(color: Colors.black87)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProfession = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Daily Routine[cite: 11]
              const Text(
                'Daily routine',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildChip('Early start', _selectedRoutines),
                  _buildChip('Desk-based', _selectedRoutines),
                  _buildChip('Active day', _selectedRoutines),
                  _buildChip('Cook in 30 min', _selectedRoutines),
                  _buildChip('Weekend prep', _selectedRoutines),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Only you can see your health preferences.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom Fixed Button[cite: 11]
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF9F9),
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                // Navigate to the next page (e.g., Home Page)
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text(
                'Personalize my kitchen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Standard Chip Builder[cite: 11]
  Widget _buildChip(String label, Set<String> selectedSet) {
    final isSelected = selectedSet.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedSet.remove(label) : selectedSet.add(label);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _primaryColor : _chipInactiveBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : _primaryColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Green Chip Builder for Health Tags[cite: 11]
  Widget _buildGreenChip(String label, Set<String> selectedSet) {
    final isSelected = selectedSet.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? selectedSet.remove(label) : selectedSet.add(label);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _greenBg : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? _greenText : Colors.grey.shade600,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}