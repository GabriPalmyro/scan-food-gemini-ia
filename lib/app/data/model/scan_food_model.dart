import 'package:diet_scan_ia/app/data/model/ingredient_model.dart';
import 'package:diet_scan_ia/app/data/model/macros_model.dart';

class ScanFoodModel {
  ScanFoodModel({
    required this.foodName,
    required this.totalMacros,
    required this.totalCalories,
    required this.ingredients,
    required this.description,
  });

  factory ScanFoodModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ingredients = json['ingredients'];
    final String? description = json['description'];
    final String foodName = json['foodName'];
    final MacrosModel totalMacros = MacrosModel.fromJson(json['totalMacros']);
    final String totalCalories = json['totalCalories'];

    return ScanFoodModel(
      foodName: foodName,
      totalMacros: totalMacros,
      totalCalories: totalCalories,
      ingredients: ingredients.map((e) => IngredientModel.fromJson(e)).toList(),
      description: description,
    );
  }

  final String foodName;
  final MacrosModel totalMacros;
  final String totalCalories;
  final List<IngredientModel> ingredients;
  final String? description;
}
