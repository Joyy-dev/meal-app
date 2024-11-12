import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widget/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen (this.availableMeals, {super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
     categoryTitle = routeArgs['title']!;
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal (String mealid) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),

      body: ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title, 
          imageUrl: displayedMeals[index].imageUrl, 
          duration: displayedMeals[index].duration, 
          complexity: displayedMeals[index].complexity, 
          affordability: displayedMeals[index].affordability,
          );
      }, itemCount: displayedMeals.length,),
      backgroundColor: const Color(0xFFFFFEED),
    );
  }
}