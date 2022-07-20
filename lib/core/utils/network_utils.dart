import 'package:http/http.dart' as http;

class Network{
  final String _url = 'https://test1.kopelindo.co.id/api';
  var token;

  login(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: data,
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
    );
  }
}