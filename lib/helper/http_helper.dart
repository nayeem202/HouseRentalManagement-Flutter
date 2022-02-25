import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'http_exception.dart';
// import 'http_exception.dart';
// import 'http_exception.dart';

class HttpHelper {
  Future<dynamic> getData(url) async {
    var responseJson;
    try {
      //ToDo: add token
      var headers = {
        "Content-Type": "application/json",
        //'Authorization': 'Bearer '
      };
      var uri =Uri.parse(url);
      final response = await get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postData(String _url, dynamic _body) async {
    var responseJson;
    //ToDo: add token
    try {
      Uri url = Uri.parse(_url);
      var headers = {
        "Content-Type": "application/json",
        //'Authorization': 'Bearer '
      };
      final response = await post(url, headers: headers, body: _body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        try {
          Map<dynamic, dynamic> responseJson = json.decode(response.body);
          var data = responseJson['message'];
          throw BadRequestException(data.toString());
        } catch (e) {}
        break;
      case 412:
        return response;
      case 401:
      //TokenHandler.refreshToken();
        Map<dynamic, dynamic> responseJson = json.decode(response.body);
        dynamic data = responseJson['message'];
        throw UnauthorisedException(data.join('\n'));
      case 403:
        Map<dynamic, dynamic> responseJson = json.decode(response.body);
        var data = responseJson['message'];
        throw UnauthorisedException(data.toString());
      case 500:
      default:
        Map<dynamic, dynamic> responseJson = json.decode(response.body);
        var data = responseJson['message'];
        log("error: " + data.toString());
        throw FetchDataException(
            'Server side error. Please contact with your support team');
    }
  }
}
