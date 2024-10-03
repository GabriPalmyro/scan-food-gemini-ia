import 'dart:io';

import 'package:diet_scan_ia/app/presentation/bloc/scan_food/scan_food_cubit.dart';
import 'package:diet_scan_ia/app/presentation/bloc/scan_food/scan_food_state.dart';
import 'package:diet_scan_ia/app/presentation/widgets/food_info_modal.dart';
import 'package:diet_scan_ia/app/presentation/widgets/scan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanFoodPage extends StatefulWidget {
  const ScanFoodPage({required this.cubit, super.key});
  final ScanFoodCubit cubit;

  @override
  State<ScanFoodPage> createState() => _ScanFoodPageState();
}

class _ScanFoodPageState extends State<ScanFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: BlocConsumer<ScanFoodCubit, ScanFoodState>(
        bloc: widget.cubit,
        listener: (context, state) {
          if (state is ScanFoodStateSuccess) {
            final scan = state.scan;
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return FoodInfoBottomSheet(
                  foodName: scan.foodName,
                  description: scan.description,
                  totalCalories: scan.totalCalories,
                  totalMacros: scan.totalMacros,
                  ingredients: scan.ingredients,
                );
              },
            );
          } else if (state is ScanFoodStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ScanFoodStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ScanWidget(
                  onImageCaptured: (image) {
                    widget.cubit.generate(
                      File(image.path),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
