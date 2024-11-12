import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widget/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritemeals;

  const FavoritesScreen(this.favoritemeals, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favoritemeals.isEmpty) {
      return const Center(
      child: Text('You have no favorites yet - start adding some!'),
    );
    } else {
      return ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
          id: favoritemeals[index].id,
          title: favoritemeals[index].title, 
          imageUrl: favoritemeals[index].imageUrl, 
          duration: favoritemeals[index].duration, 
          complexity: favoritemeals[index].complexity, 
          affordability: favoritemeals[index].affordability,
          );
      }, itemCount: favoritemeals.length,);
    }
  }
}