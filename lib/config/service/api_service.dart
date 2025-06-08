import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:digifarmer/config/netork_helper.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late final Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          // 'Api-Key': dotenv.env['API_KEY'], // Get from .env file
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.addAll({});
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<ApiResults> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure(message: 'No internet connection');
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<ApiResults> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure(message: 'No internet connection');
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<ApiResults> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure(message: 'No internet connection');
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<ApiResults> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure(message: 'No internet connection');
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<ApiResults> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure(message: 'No internet connection');
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  void _handleUnauthorized() {
    // Adjust to your actual login route
  }

  ApiFailure _handleDioError(DioException e) {
    String errorMsg = "Something went wrong";
    Map<String, dynamic>? extraData;

    if (e.response?.data is Map) {
      final data = e.response!.data as Map<String, dynamic>;
      errorMsg = data["message"] ?? errorMsg;
      log("API Error: $errorMsg");
      if (data.containsKey("data")) {
        try {
          extraData =
              data["data"] is String ? jsonDecode(data["data"]) : data["data"];
        } catch (_) {
          extraData = {};
        }
      }
    }

    return ApiFailure(
      message: errorMsg,
      statusCode: e.response?.statusCode,
      additionalData: extraData,
    );
  }
}
