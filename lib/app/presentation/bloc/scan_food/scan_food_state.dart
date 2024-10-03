import 'package:diet_scan_ia/app/data/model/scan_food_model.dart';

abstract class ScanFoodState {
  const ScanFoodState();
}

class ScanFoodStateInitial extends ScanFoodState {
  const ScanFoodStateInitial();
}

class ScanFoodStateLoading extends ScanFoodState {
  const ScanFoodStateLoading();
}

class ScanFoodStateError extends ScanFoodState {
  const ScanFoodStateError(
    this.message,
  );
  final String message;
}

class ScanFoodStateSuccess extends ScanFoodState {
  const ScanFoodStateSuccess({required this.scan});
  final ScanFoodModel scan;
}
