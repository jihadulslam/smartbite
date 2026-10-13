import 'package:flutter/material.dart';
import 'explore_page.dart';
import 'saved_page.dart';
import 'profile_page.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  final Color _primaryColor = const Color(0xFF7A232E);
  final Color _cardBgColor = const Color(0xFFF9EBEC);
  int _currentIndex = 2; // Grocery page is index 2[cite: 12]

  // Dynamic ingredient list with checked state[cite: 12]
  final List<Map<String, dynamic>> _ingredients = [
    {'name': 'Chicken breast', 'amount': '300 g', 'isChecked': true},
    {'name': 'Lemon', 'amount': '1 medium', 'isChecked': true},
    {'name': 'Onion', 'amount': '1 medium', 'isChecked': false},
    {'name': 'Plain yogurt', 'amount': '60 g', 'isChecked': false},
    {'name': 'Ginger-garlic paste', 'amount': '1 tbsp', 'isChecked': false},
    {'name': 'Turmeric', 'amount': '½ tsp', 'isChecked': false},
    {'name': 'Mustard oil', 'amount': '2 tsp', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate progress dynamically
    int totalItems = _ingredients.length;
    int checkedItems = _ingredients.where((item) => item['isChecked'] == true).length;
    int remainingItems = totalItems - checkedItems;
    double progress = totalItems == 0 ? 0 : checkedItems / totalItems;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      body: Column(
        children: [
          // Maroon Header[cite: 12]
          Container(
            width: double.infinity,
            color: _primaryColor,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Grocery list',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Card[cite: 12]
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _cardBgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Your basket is coming along',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            Text(
                              '$checkedItems / $totalItems',
                              style: TextStyle(fontSize: 14, color: _primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Linear Progress Bar[cite: 12]
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$remainingItems ingredients left to pick up',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recipe Title and Subtitle[cite: 12]
                  const Text(
                    'Sylheti lemon chicken',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'For 2 servings • Added from your recipe',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 16),

                  // Ingredients Checkbox List[cite: 12]
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: _ingredients.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> item = entry.value;
                        bool isLast = index == _ingredients.length - 1;

                        return Column(
                          children: [
                            CheckboxListTile(
                              value: item['isChecked'],
                              onChanged: (bool? value) {
                                setState(() {
                                  _ingredients[index]['isChecked'] = value!;
                                });
                              },
                              activeColor: _primaryColor,
                              checkColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: item['isChecked'] ? Colors.grey.shade500 : Colors.black87,
                                      decoration: item['isChecked'] ? TextDecoration.lineThrough : TextDecoration.none, // Strikethrough effect[cite: 12]
                                    ),
                                  ),
                                  Text(
                                    item['amount'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: item['isChecked'] ? Colors.grey.shade400 : Colors.grey.shade700,
                                      decoration: item['isChecked'] ? TextDecoration.lineThrough : TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isLast) Divider(color: Colors.grey.shade100, height: 1, indent: 56, endIndent: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Add an item button[cite: 12]
                  SizedBox(
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
                      onPressed: () {
                        // TODO: Add new item logic
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: _primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Add an item',
                            style: TextStyle(
                              color: _primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar[cite: 12]
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst); // Go back to Home
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExplorePage()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SavedPage()));
          } else if (index == 4) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
}