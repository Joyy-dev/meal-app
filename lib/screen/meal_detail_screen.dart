import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavorite;
  final Function mealFavorite;

  const MealDetailScreen(this.toggleFavorite, this.mealFavorite, {super.key});

  Widget buildsectiontitle(BuildContext context, String text) {
    return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
    );
  }

  Widget buildcontainer(Widget child) {
    return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E4),
            border: Border.all(color: const Color(0xFF283618)),
            borderRadius: BorderRadius.circular(18)
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 180, 
          width: 370,
          child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealid = ModalRoute.of(context)!.settings.arguments as String;
    final selectMeal = dummy_meals.firstWhere((meal) => meal.id == mealid);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(selectMeal.imageUrl,
            fit: BoxFit.cover,
            ),
          ),
          buildsectiontitle(context, 'Ingredients'),
          buildcontainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: const Color.fromARGB(255, 187, 167, 53),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(selectMeal.ingredients[index])
                  ),
              ),
              itemCount: selectMeal.ingredients.length,
              ),
            ),
          buildsectiontitle(context, 'Steps For Preparation'),
          buildcontainer(
            ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF283618),
                      foregroundColor: const Color(0xFFFFF8E4),
                      child: Text('${(index + 1)}'
                      ),
                    ),
                    title: Text(selectMeal.steps[index]),
                    ),
                    const Divider(color: Color(0xFF283618),)
                ],
              ),
                itemCount: selectMeal.steps.length,
              ),
              ),
        ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(mealFavorite(mealid) ? Icons.star : Icons.star_border,),
        onPressed: () => toggleFavorite(mealid)
        ),
    );
  }
}