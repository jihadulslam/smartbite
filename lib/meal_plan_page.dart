import 'package:flutter/material.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  final Color _primaryColor = const Color(0xFF7A232E);
  final Color _bgColor = const Color(0xFFFAF9F9);

  int _selectedDayIndex = 0; // Saturday selected[cite: 14]

  final List<Map<String, String>> _days = [
    {'day': 'Sat', 'date': '3'},
    {'day': 'Sun', 'date': '4'},
    {'day': 'Mon', 'date': '5'},
    {'day': 'Tue', 'date': '6'},
    {'day': 'Wed', 'date': '7'},
    {'day': 'Thu', 'date': '8'},
    {'day': 'Fri', 'date': '9'},
  ];

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
          'Plan your week',
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
            // Date Header[cite: 14]
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.chevron_left, size: 20, color: Colors.grey.shade500),
                    Text('3–9 October 2026', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
                Row(
                  children: [
                    Text('Next week', style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                    Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade400),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Days Row[cite: 14]
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_days.length, (index) {
                bool isSelected = _selectedDayIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDayIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? _primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _days[index]['day']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _days[index]['date']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Menu Title[cite: 14]
            const Text(
              'Saturday’s menu',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              '3 meals planned · 1 person',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),

            // Meal Cards[cite: 14]
            _buildMealCard(
              type: 'BREAKFAST · 8:00 AM',
              title: 'Egg & vegetable ruti',
              details: '20 min · 340 kcal',
              imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=200',
            ),
            const SizedBox(height: 16),
            _buildMealCard(
              type: 'LUNCH · 1:00 PM',
              title: 'Sylheti lemon chicken',
              details: '30 min · 285 kcal / serving',
              imageUrl: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=200',
            ),
            const SizedBox(height: 16),
            _buildMealCard(
              type: 'DINNER · 7:30 PM',
              title: 'Vegetable bhuna khichuri',
              details: '35 min · 320 kcal / serving',
              imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=200',
            ),
            const SizedBox(height: 24),

            // Planned meal totals card[cite: 14]
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
                      const Text('Planned meal totals', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Text('945 kcal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _primaryColor)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Protein 63 g · Carbs 111 g · Fat 28 g', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  const SizedBox(height: 8),
                  Text('Meals only; snacks and drinks are not included.', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Fixed Button[cite: 14]
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: _bgColor,
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
              onPressed: () {},
              child: const Text(
                'Build grocery list · 7 ingredients',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for meal cards[cite: 14]
  Widget _buildMealCard({required String type, required String title, required String details, required String imageUrl}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, height: 64, width: 64, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _primaryColor, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(details, style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}