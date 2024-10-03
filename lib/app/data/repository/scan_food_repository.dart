import 'dart:io';

import 'package:diet_scan_ia/app/data/model/scan_food_model.dart';
import 'package:diet_scan_ia/app/data/service/gemini_service.dart';
import 'package:diet_scan_ia/app/domain/boundary/scan_food_repository.dart';

class ScanFoodRepositoryImpl extends ScanFoodRepository {
  ScanFoodRepositoryImpl({required this.geminiIAService});

  final GeminiIAService geminiIAService;

  @override
  Future<ScanFoodModel> scanFood(File image) async {
    const message = '''
      Me de em um formato de json os ingredientes desse prato, como suas respectivas calorias, 
      macros nutrientes de gordura, proteina e carboidrato e descreva o maximo possivel do prato
      
      Regras:
      me devolva o total de calorias e macros do prato, e o nome do prato.
      me devolva o total de calorias e macros de cada ingrediente, e o nome do ingrediente.
      Nao me retorne nada null ou vazio.
      Nao me retorna um description vazio, sempre me retorne uma descrição do prato vazia como ""

      Utilize esse json como exemplo:
      {
        "foodName: "Prato de PF",
        "totalMacros": {
            "fat": "3.5g",
            "protein": "35g",
            "carbohydrate": "44g"
        },
        "totalCalories": "370kcal",
        "ingredients":[
            {
              "name":"Frango Grelhado",
              "calories":"165kcal",
              "macros":{
                  "fat":"3g",
                  "protein":"31g",
                  "carbohydrate":"0g"
              }
            },
            {
              "name":"Arroz Branco",
              "calories":"205kcal",
              "macros":{
                  "fat":"0.5g",
                  "protein":"4g",
                  "carbohydrate":"44g"
              }
            },
        ],
        "description":"O prato é composto por frango grelhado, arroz branco, feijão, alface, tomate, repolho e cenoura. É um prato nutritivo e completo, com boa quantidade de proteína, carboidratos e fibras. O frango grelhado é uma boa fonte de proteína, o arroz branco é uma boa fonte de carboidratos, o feijão é uma boa fonte de fibra e proteína, a alface é uma boa fonte de vitaminas e minerais, o tomate é uma boa fonte de vitamina C, o repolho é uma boa fonte de vitamina K e a cenoura é uma boa fonte de vitamina A."
      }
    ''';

    final content = await geminiIAService.generateContentFromTextAndFile(
      message,
      image,
    );

    return ScanFoodModel.fromJson(content);
  }
}
