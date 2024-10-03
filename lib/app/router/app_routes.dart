import 'package:diet_scan_ia/app/common/google_gemini_ia/geminia_ia.dart';
import 'package:diet_scan_ia/app/data/repository/scan_food_repository.dart';
import 'package:diet_scan_ia/app/data/service/gemini_service.dart';
import 'package:diet_scan_ia/app/presentation/bloc/scan_food/scan_food_cubit.dart';
import 'package:diet_scan_ia/app/presentation/scan_food_page.dart';
import 'package:diet_scan_ia/app/router/routes.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => ScanFoodPage(
            cubit: ScanFoodCubit(
              ScanFoodRepositoryImpl(
                geminiIAService: GeminiIAServiceImpl(
                  instance: GeminiaIAInstance(
                    'SUA-API-KEY',
                  ),
                ),
              ),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
