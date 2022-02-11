import '/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices{
  Dio? dio;
   CharactersWebServices(){
     BaseOptions options = BaseOptions(
       baseUrl: baseUrl,
       receiveDataWhenStatusError: true,
       connectTimeout: 20 * 1000,
       receiveTimeout: 20 * 1000,
     );
     dio = Dio(options);
   }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio!.get('characters');
      return response.data;
    } catch (e) {
      return [];
    }

  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio!.get('quote', queryParameters: {'author' :charName});
      return response.data;
    } catch (e) {
      return [];
    }

  }
}