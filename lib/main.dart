import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screen/categories_screen.dart';
import 'package:mealapp/screen/category_meals_screen.dart';
import 'package:mealapp/screen/filter_screen.dart';
import 'package:mealapp/screen/meal_detail_screen.dart';
import 'package:mealapp/screen/tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummy_meals;
  final List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummy_meals.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVeganFree) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealid) {
    final existingIndex =
       _favoritesMeals.indexWhere((meal) => meal.id == mealid);
    if (existingIndex >= 0) {
      setState(() {
        _favoritesMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritesMeals.add(dummy_meals.firstWhere((meal) => meal.id == mealid));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChoppyMeal',
      //home: const CategoriesScreen(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        canvasColor: const Color(0xFF5F0F40), 
        scaffoldBackgroundColor: const Color(0xFFFFFDF0),
        fontFamily: 'Quicksand',
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFFA3B18A),
          unselectedLabelColor: Color(0xFFE9F1F7),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF283618),
          foregroundColor: Colors.white,
          shape: CircleBorder(
            side: BorderSide.none, 
            eccentricity: BorderSide.strokeAlignCenter
          )
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(
            color: Color(0xFF283618),
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          titleLarge:  const TextStyle(
            color: Color(0xFFFEFAE0),
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        bodySmall:  const TextStyle(
            color: Color(0xFF283618),
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.normal
        ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF04471C),
          titleTextStyle: TextStyle(
            color: Color(0xFFEDEDE9),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand'
          ),
          iconTheme: IconThemeData(
            color: Color(0xFFEDEDE9)
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoritesMeals),
        CategoryMealsScreen.routeName:(ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters)
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen(),);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}