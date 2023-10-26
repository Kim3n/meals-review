import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/widgets/meal_item.dart';

/// A screen that displays a list of meals.
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    Key? key, // Adding 'Key?' to the parameter.
    this.title,
    required this.meals,
  }) : super(key: key); // Call the super constructor with the provided key.

  final String? title;
  final List<Meal> meals;

  // Function to navigate to the meal detail screen.
  void _showMealScreen(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealDetailScreen(
        meal: meal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Create a ListView of meal items.
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return MealItem(
          meal: meals[index],
          onMealItemTap: () {
            _showMealScreen(context, meals[index]);
          },
        );
      },
    );

    // Check if there are no meals, and display a message accordingly.
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oh.. Nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    // Check if a title is provided and create a Scaffold with an app bar.
    if (title == null) {
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
      );
    }
  }
}
