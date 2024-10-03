import 'package:diet_scan_ia/app/router/app_routes.dart';
import 'package:diet_scan_ia/app/router/routes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet Scan IA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: Routes.home,
    );
  }
}
