import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiaIAInstance {
  GeminiaIAInstance(this.apiKey) {
    initializeModel(apiKey);
  }

  final String apiKey;

  late final GenerativeModel generativeModel;

  void initializeModel(String apiKey) {
    generativeModel = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 64,
        maxOutputTokens: 10000,
        responseMimeType: 'application/json',
      ),
    );
  }
}
