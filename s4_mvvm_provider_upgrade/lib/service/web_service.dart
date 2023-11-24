import 'dart:io';
import 'package:dio/dio.dart';
import '../api/app_exception.dart';
import '../model/user_model.dart';

class WebService {
  var dio = Dio();
  String endpoint = 'https://reqres.in/api/users?page=1';

  Future<List<UserModel>> getUser() async {
    Response response = await dio.get(endpoint);
    if (response.statusCode == 200) {
      final List result = response.data['data'] as List;
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
  Future getResponse() async {
    dynamic responseJson;
    try {
      final response = await dio.get(endpoint);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.statusMessage);
      case 404:
        throw UnauthorisedException(response.statusMessage);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}