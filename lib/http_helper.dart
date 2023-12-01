import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpHelper {
  static Future<List<dynamic>> fetchData(String url) async {
    try {
      var result = await http.get(Uri.parse(url));

      if (result.statusCode == 200) {
        return jsonDecode(result.body);
      } else {
        print('서버 응답이 실패했습니다. 응답 코드: ${result.statusCode}');
        return [];
      }
    } catch (error) {
      print('서버 통신 중 에러가 발생했습니다: $error');
      return [];
    }
  }
}
