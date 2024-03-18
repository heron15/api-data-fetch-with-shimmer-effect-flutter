import 'dart:convert';

import 'package:api_data_fetch_practrice/fetch_data_with_model/model/paragraph_model.dart';
import 'package:http/http.dart' as http;

class ParagraphModelHelper {
  static Future<List<ParagraphApi>> getDataFetch() async {
    const url =
        'https://anticipatory-indust.000webhostapp.com/paragraph_app/paragraphResponse.php';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json as List<dynamic>;
    final paragraphData = results.map((e) {
      return ParagraphApi(
          id: e['id'], title: e['title'], paragraph: e['paragraph']);
    }).toList();
    return paragraphData;
  }
}
