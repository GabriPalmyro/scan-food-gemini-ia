import 'package:diet_scan_ia/app/data/model/macros_model.dart';

class IngredientModel {
  IngredientModel({
    required this.name,
    required this.calories,
    required this.macros,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'],
      calories: json['calories'],
      macros: MacrosModel.fromJson(json['macros']),
    );
  }
  String name;
  String calories;
  MacrosModel macros;
}
