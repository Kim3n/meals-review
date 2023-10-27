import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

enum Rating {
  poor(str: 'Bad', icon: Icons.sentiment_very_dissatisfied),
  average(str: 'Okay', icon: Icons.sentiment_satisfied),
  excellent(str: 'Good', icon: Icons.sentiment_very_satisfied);

  final String str;
  final IconData icon;
  const Rating({required this.str, required this.icon});
}

class ReviewedNotifier extends StateNotifier<List<(Meal, Rating)>> {
  ReviewedNotifier() : super([]);

  void addReview(Meal meal, Rating rating) {
    state = [...state, (meal, rating)];
  }

  void removeReview(Meal meal) {
    state = state.where((element) => element.$1.id != meal.id).toList();
  }
}

/// A provider that exposes the list of completed meals along with their ratings.
/// Has a notifier that can be used to add and remove reviews.
final reviewedProvider =
    StateNotifierProvider<ReviewedNotifier, List<(Meal, Rating)>>((ref) {
  return ReviewedNotifier();
});

/// A provider that exposes the list of completed meals.
final reviewedMealsProvider = Provider<List<Meal>>((ref) {
  return ref.watch(reviewedProvider).map((e) => e.$1).toList();
});
