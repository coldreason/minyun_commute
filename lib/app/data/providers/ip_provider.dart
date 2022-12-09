import 'package:get/get.dart';
import "package:http/http.dart" as http;

class IPProvider extends GetConnect {
  Future<String?> getIP() async {
    try {
      const url = 'https://api.ipify.org';
      Uri uri = Uri.parse(url);
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print(response.body);
        return null;
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
