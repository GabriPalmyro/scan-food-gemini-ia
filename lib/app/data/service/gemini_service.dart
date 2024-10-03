import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:diet_scan_ia/app/common/google_gemini_ia/geminia_ia.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class GeminiIAService {
  Future<Map<String, dynamic>> generateContentFromTextAndFile(String message, [File? image]);
}

class GeminiIAServiceImpl implements GeminiIAService {
  GeminiIAServiceImpl({required this.instance});
  final GeminiaIAInstance instance;

  @override
  Future<Map<String, dynamic>> generateContentFromTextAndFile(
    String message, [
    File? image,
  ]) async {
    final model = instance.generativeModel;

    final List<Part> dataParts = [];

    if (image != null) {
      final imgBytes = await image.readAsBytes();
      // Lookup function from the mime plugin
      final imageMimeType = 'image/${image.path.split('.').last}';
      dataParts.add(DataPart(imageMimeType, imgBytes));
    }

    dataParts.add(TextPart(message));

    final response = await model.generateContent([
      Content.multi(dataParts),
    ]);

    if (response.text == null) {
      throw Exception('Failed to generate content');
    }

    log(response.text!, name: 'GeminiIAService Response Text');

    return jsonDecode(response.text!);
  }
}
