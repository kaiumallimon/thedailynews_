import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl:
          'https://thedailynews-eight.vercel.app/api/v1', // Replace with your API base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    _dio.interceptors.addAll([_LoggingInterceptor(), _ErrorInterceptor()]);

    // Enable logging in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  Dio get dio => _dio;

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      );
    }
    super.onError(err, handler);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err.response);
          case 401:
            throw UnauthorizedException(err.requestOptions, err.response);
          case 403:
            throw ForbiddenException(err.requestOptions, err.response);
          case 404:
            throw NotFoundException(err.requestOptions, err.response);
          case 500:
            throw InternalServerErrorException(
              err.requestOptions,
              err.response,
            );
          default:
            throw UnknownException(err.requestOptions, err.response);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw UnknownException(err.requestOptions, err.response);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions, err.response);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(err.requestOptions, err.response);
    }
    return handler.next(err);
  }
}

// Custom Exceptions
class TimeoutException extends DioException {
  TimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again!';
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Access denied';
  }
}

class ForbiddenException extends DioException {
  ForbiddenException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Access forbidden';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class UnknownException extends DioException {
  UnknownException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class BadCertificateException extends DioException {
  BadCertificateException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Bad certificate error occurred';
  }
}

class ConnectionErrorException extends DioException {
  ConnectionErrorException(RequestOptions r, Response? response)
    : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Connection error occurred';
  }
}
