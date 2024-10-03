import 'dart:developer';
import 'dart:io';

import 'package:diet_scan_ia/app/domain/boundary/scan_food_repository.dart';
import 'package:diet_scan_ia/app/presentation/bloc/scan_food/scan_food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanFoodCubit extends Cubit<ScanFoodState> {
  ScanFoodCubit(this.repository) : super(const ScanFoodStateInitial());

  final ScanFoodRepository repository;

  Future<void> generate(File file) async {
    emit(const ScanFoodStateLoading());
    try {
      final scan = await repository.scanFood(file);
      emit(ScanFoodStateSuccess(scan: scan));
    } catch (e) {
      log(e.toString(), error: e, name: 'ScanFoodCubit Generate Error');
      emit(ScanFoodStateError(e.toString()));
    }
  }
}
