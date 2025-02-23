import 'package:flutter/material.dart';
import 'package:mealapp/widget/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
        ),
        children: dummy_categories.map((catData) => 
        CategoryItem(catData.id, catData.title, catData.color)
        ).toList(),
      );
  }
}