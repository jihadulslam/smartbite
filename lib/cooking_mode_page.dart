import 'package:flutter/material.dart';

class CookingModePage extends StatefulWidget {
  const CookingModePage({super.key});

  @override
  State<CookingModePage> createState() => _CookingModePageState();
}

class _CookingModePageState extends State<CookingModePage> {
  final Color _primaryColor = const Color(0xFF7A232E);
  final Color _bgColor = const Color(0xFFFAF9F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cooking mode',
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Title & Meta[cite: 15]
            const Text(
              'Sylheti lemon chicken',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              '30 min · 2 servings · Keep screen awake',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 16),

            // Step Progress Bars[cite: 15]
            Row(
              children: [
                _buildProgressSegment(isActive: true, isCompleted: true),
                const SizedBox(width: 4),
                _buildProgressSegment(isActive: true, isCompleted: false),
                const SizedBox(width: 4),
                _buildProgressSegment(isActive: false, isCompleted: false),
                const SizedBox(width: 4),
                _buildProgressSegment(isActive: false, isCompleted: false),
                const SizedBox(width: 4),
                _buildProgressSegment(isActive: false, isCompleted: false),
              ],
            ),
            const SizedBox(height: 24),

            // Main Image[cite: 15]
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=800', // Chicken image
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Step Indicator Text[cite: 15]
            Text(
              'STEP 2 OF 5 · MARINATE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: _primaryColor,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            // Step Title & Description[cite: 15]
            const Text(
              'Let the flavours settle.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Text(
              'Coat the chicken with yogurt, lemon juice, ginger–garlic paste and turmeric. Rest for 10 minutes while you slice the onion.',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.5),
            ),
            const SizedBox(height: 16),

            // Ingredient Chips[cite: 15]
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildIngredientChip('Chicken · 300 g'),
                _buildIngredientChip('Yogurt · 60 g'),
                _buildIngredientChip('½ tsp turmeric'),
              ],
            ),
            const SizedBox(height: 24),

            // Timer Card[cite: 15]
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF9EBEC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_outlined, color: _primaryColor, size: 24),
                          const SizedBox(width: 40),
                          Text(
                            '10:00',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: _primaryColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.play_arrow, color: _primaryColor, size: 20),
                          const SizedBox(width: 4),
                          Text('Start', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _primaryColor)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Resting timer · ready when you are',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Up Next Text[cite: 15]
            Text(
              'Up next: soften the onion in 2 tsp mustard oil.',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Navigation Buttons (Previous / Next)[cite: 15]
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 55,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Previous',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _primaryColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Next step',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Progress Segments[cite: 15]
  Widget _buildProgressSegment({required bool isActive, required bool isCompleted}) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: isActive ? _primaryColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  // Helper Widget for Ingredient Chips[cite: 15]
  Widget _buildIngredientChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9EBEC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(color: _primaryColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}