import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import 'grocery_page.dart';
import 'saved_page.dart';
import 'profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final Color _primaryColor = const Color(0xFF7A232E);
  int _currentIndex = 1; // Explore page is index 1

  // Search controller and state[cite: 12]
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dummy Recipe Data[cite: 12]
  final List<Map<String, String>> _allRecipes = [
    {
      'title': 'Sylheti lemon chicken',
      'tag': 'Sylhet',
      'time': '30 min',
      'calories': '285 kcal / serving',
      'imageUrl': 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=500',
    },
    {
      'title': 'Ginger chicken bhuna',
      'tag': 'Dhaka',
      'time': '25 min',
      'calories': '310 kcal / serving',
      'imageUrl': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500',
    },
    {
      'title': 'Beef Kala Bhuna',
      'tag': 'Chattogram',
      'time': '45 min',
      'calories': '450 kcal / serving',
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-811114215755?w=500',
    },
    {
      'title': 'Prawn Malai Curry',
      'tag': 'Khulna',
      'time': '40 min',
      'calories': '320 kcal / serving',
      'imageUrl': 'https://images.unsplash.com/photo-1559742811-822873691df8?w=500',
    },
  ];

  // This function filters recipes based on search query[cite: 12]
  List<Map<String, String>> get _filteredRecipes {
    if (_searchQuery.isEmpty) {
      return _allRecipes;
    }
    return _allRecipes.where((recipe) {
      return recipe['title']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Find your next meal',
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

          // Search and Filters Section[cite: 12]
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search recipes',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),

                // Working Search Bar[cite: 12]
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value; // Updates the UI instantly as you type
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'e.g. Chicken, Beef...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
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
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Chips Row[cite: 12]
                Row(
                  children: [
                    _buildFilterChip('All districts ∨', const Color(0xFFF9EBEC), _primaryColor),
                    const SizedBox(width: 8),
                    _buildFilterChip('≤ 30 min ∨', _primaryColor, Colors.white),
                    const SizedBox(width: 8),
                    _buildFilterChip('High Protein', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Results Count & Sort[cite: 12]
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_filteredRecipes.length} recipes found',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Sort: Recommended',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search Results List (Dynamically updating)[cite: 12]
          Expanded(
            child: _filteredRecipes.isEmpty
                ? Center(
              child: Text(
                'No recipes found for "$_searchQuery"',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = _filteredRecipes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildRecipeCard(
                    title: recipe['title']!,
                    tag: recipe['tag']!,
                    time: recipe['time']!,
                    calories: recipe['calories']!,
                    imageUrl: recipe['imageUrl']!,
                  ),
                );
              },
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
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroceryPage()));
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

  // Filter Chip Widget[cite: 12]
  Widget _buildFilterChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Recipe Card Widget[cite: 12]
  Widget _buildRecipeCard({
    required String title,
    required String tag,
    required String time,
    required String calories,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecipeDetailPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image[cite: 12]
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tag[cite: 12]
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9EBEC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(color: _primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Bookmark icon[cite: 12]
                      Icon(Icons.bookmark_border, color: _primaryColor, size: 22),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$time  •  $calories',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}