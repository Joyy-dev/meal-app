import 'package:flutter/material.dart';
import 'package:mealapp/screen/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem(this.id, this.title, this.color, {super.key});

  void _selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, 
    arguments: {
      'id': id, 
      'title': title}
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [color.withOpacity(0.67),
          color,
          ],
          center: Alignment.center,
          radius: 0.85
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(title,
        style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}