import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/completed_provider.dart';
import 'package:meals/screens/meal_detail_screen.dart';

/// A screen that displays the meals that have been reviewed, along with their ratings.
class ReviewedScreen extends ConsumerWidget {
  const ReviewedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the list of reviewed meals and their ratings from the provider.
    final mealsAndReviews = ref.watch(reviewedProvider);

    // Create a widget to display the meal reviews or a message if there are none.
    var mealReviews = mealsAndReviews.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                ...mealsAndReviews
                    .map((e) => MealReview(meal: e.$1, rating: e.$2))
                    .toList()
              ],
            ),
          )
        : Center(
            heightFactor: 2,
            child: Text(
              'No Reviewed meals yet.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          );

    // Create a Scaffold for the screen.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviewed meals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mealReviews,
      ),
    );
  }
}

class MealReview extends ConsumerWidget {
  const MealReview({Key? key, required this.meal, required this.rating})
      : super(key: key);

  final Meal meal;
  final Rating rating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the meal detail screen when the user taps the meal.
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MealDetailScreen(meal: meal),
            ));
          },
          child: Container(
            width: double.infinity,
            // Make the container rounded by 5px with a primary color background.
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Row(
                        children: [
                          Text(
                            rating.str,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            rating.icon,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Remove the review when the user taps the delete button.
                    ref.read(reviewedProvider.notifier).removeReview(meal);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
