import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screen/Favorites_screen.dart';
import 'package:mealapp/screen/categories_screen.dart';
import 'package:mealapp/widget/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoritemeals;
  const TabScreen(this.favoritemeals, {super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedPagesIndex = 0;

  @override
  void initState() {
    _pages =  [
    {'page': const CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoritesScreen(widget.favoritemeals), 'title': 'Your Favourites'}
  ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPagesIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPagesIndex]['title'] as String),

      ),

      drawer: const MainDrawer(),

      body: _pages[_selectedPagesIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: const Color(0xFF3A5A40),
        selectedItemColor: const Color.fromARGB(255, 235, 240, 255),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPagesIndex,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF344E41),
            icon: Icon(Icons.category), 
            label: 'categories'
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF3A5A40),
            icon: Icon(Icons.star), 
            label: 'Favorites'
            )
        ]
        ),
    );
  }
}