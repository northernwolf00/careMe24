import 'dart:developer';
import 'package:careme24/service/env_service.dart';
import 'package:dio/dio.dart';

class HttpManager {

  HttpManager._privateConstructor()
      : _dio = Dio(
          BaseOptions(
            baseUrl: EnvService().apiUrl,  
            connectTimeout: const Duration(seconds: 10),
            headers: {},
          ),
        ),
        _defaultBaseUrl = EnvService().apiUrl;   

  static final HttpManager _instance = HttpManager._privateConstructor();

  static HttpManager get instance => _instance;

  final Dio _dio;
  final String _defaultBaseUrl;   

  String? _token;

  void setToken(String token) {
    _token = token;
    _dio.options.headers['Authorization'] = 'Bearer $_token';
  }

  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  void resetToken() {
    _token = null;
    _dio.options.headers.remove('Authorization');
    log('Token has been reset');
  }


  void resetBaseUrl() {
    _dio.options.baseUrl = _defaultBaseUrl;
  }
  Future<dynamic> get(String url, {String? customBaseUrl, dynamic params}) async {
    try {
      String previousBaseUrl = _dio.options.baseUrl;  

      if (customBaseUrl != null) {
        setBaseUrl(customBaseUrl);
      }

      final response = await _dio.get(url, queryParameters: params);

      setBaseUrl(previousBaseUrl);
      return response.data;
    } on DioException catch (error) {
      log('GET Error: $error');
    }
  }

  Future<dynamic> post(String url, {String? customBaseUrl, dynamic data, dynamic params}) async {
    try {
      String previousBaseUrl = _dio.options.baseUrl;   

      if (customBaseUrl != null) {
        setBaseUrl(customBaseUrl);
      }

      final response = await _dio.post(url, data: data, queryParameters: params);

      setBaseUrl(previousBaseUrl);

      return response.data;
    } on DioException catch (error) {
      log('POST Error: $error');
    }
  }

  Future<dynamic> delete(String url, {String? customBaseUrl, dynamic data, dynamic params}) async {
    try {
      String previousBaseUrl = _dio.options.baseUrl;  

      if (customBaseUrl != null) {
        setBaseUrl(customBaseUrl);
      }

      final response = await _dio.delete(url, data: data, queryParameters: params);

      setBaseUrl(previousBaseUrl);

      return response.data;
    } on DioException catch (error) {
      log('DELETE Error: $error');
    }
  }

  Future<dynamic> patch(String url, {String? customBaseUrl, dynamic data, dynamic params}) async {
    try {
      String previousBaseUrl = _dio.options.baseUrl;  

      if (customBaseUrl != null) {
        setBaseUrl(customBaseUrl);
      }

      final response = await _dio.patch(url, data: data, queryParameters: params);

      setBaseUrl(previousBaseUrl);

      return response.data;
    } on DioException catch (error) {
      log('PATCH Error: $error');
    }
  }

  Future<dynamic> put(String url, {String? customBaseUrl, dynamic data, dynamic params}) async {
    try {
      String previousBaseUrl = _dio.options.baseUrl;  

      if (customBaseUrl != null) {
        setBaseUrl(customBaseUrl);
      }

      final response = await _dio.put(url, data: data, queryParameters: params);

      setBaseUrl(previousBaseUrl);

      return response.data;
    } on DioException catch (error) {
      log('Put Error: $error');
    }
  }
}
