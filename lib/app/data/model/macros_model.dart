class MacrosModel {

  MacrosModel({
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory MacrosModel.fromJson(Map<String, dynamic> json) {
    return MacrosModel(
      protein: json['protein'],
      carbs: json['carbohydrate'],
      fat: json['fat'],
    );
  }

  final String protein;
  final String carbs;
  final String fat;

  Map<String, dynamic> toJson() {
    return {
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}