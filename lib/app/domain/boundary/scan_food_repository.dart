import 'dart:io';

import 'package:diet_scan_ia/app/data/model/scan_food_model.dart';

abstract class ScanFoodRepository {
  Future<ScanFoodModel> scanFood(File image);
}