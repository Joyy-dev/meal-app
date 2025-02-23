import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screen/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({super.key, 
    required this.id,
    required this.title, 
    required this.imageUrl, 
    required this.duration, 
    required this.complexity, 
    required this.affordability,
  });

  String get ComplexityText {
    switch(complexity) {
      case Complexity.Simple:
      return 'Simple';
      break;
    case Complexity.Challenging:
      return 'Challenging';
      break;
    case Complexity.Hard:
      return 'Hard';
      break;
    default:
      return 'Unknown';
    }
  }

  String get AffordabilityText {
    switch(affordability) {
      case Affordability.Affordable:
      return 'Affordable';
      break;
    case Affordability.Pricy:
      return 'Pricy';
      break;
    case Affordability.Luxurious:
      return 'Expensive';
      break;
    default:
      return 'Unknown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailScreen.routeName,
    arguments: id,
    ).then((result) {
      if (result != null) {
        //removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
          ),
          elevation: 4, 
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Stack(children: [
              ClipRRect(borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              ),
              child: Image.network(imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 360,
                  color: const Color.fromARGB(137, 15, 71, 18),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10, 
                    horizontal: 15),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFF0),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
            ),
            Padding(padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(children: [
                  const Icon(Icons.schedule,),
                  const SizedBox(width: 6,),
                  Text('$duration min')
                ],),
                Row(children: [
                  const Icon(Icons.work),
                  const SizedBox(width: 6,),
                  Text(ComplexityText)
                ],),
                Row(children: [
                  const Icon(Icons.attach_money),
                  const SizedBox(width: 6,),
                  Text(AffordabilityText)
                ],)
              ],)),
          ],
          ),
          ),
    );
  }
}