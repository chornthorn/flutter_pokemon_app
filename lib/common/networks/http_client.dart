import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/app_data.dart';

class HttpService {
  HttpService(this.dio) {
    dio.options.baseUrl = AppData.env['baseUrl'] as String;
    dio.options.receiveTimeout = AppData.receiveTimeout;
    dio.options.connectTimeout = AppData.connectTimeout;
    dio.options.sendTimeout = AppData.sendTimeout;
    dio.interceptors.add(LoggerInterceptor());
    dio.interceptors.add(ErrorInterceptors());
    // dio.interceptors.add(ErrorQueuedInterceptors());
  }

  final Dio dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return dio.get(
      path,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return dio.post(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.put(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> head<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.head(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.delete(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.patch(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) {
    return dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  // read
  Future<Response<T>> read<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return dio.get(
      path,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> fetch<T>(RequestOptions requestOptions) {
    throw 'implement onError';
  }
}

class LoggerInterceptor extends QueuedInterceptorsWrapper {
  LoggerInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      name: 'Log: onResponse',
      'StatusCode: ${response.statusCode} => Path: ${response.requestOptions.path} => Message: ${response.statusMessage}',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      name: 'Log: onError',
      'StatusCode: ${err.response?.statusCode} => Path: ${err.response?.requestOptions.path} => Message: ${err.response?.statusMessage}',
    );
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      name: 'Log: onRequest',
      'Method: ${options.method} => Path: ${options.path}',
    );
    super.onRequest(options, handler);
  }
}

class ErrorInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['content-type'] = 'application/json';
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      'ERROR CODE: [${err.response?.statusCode}] => PATH: ${err.requestOptions.path} => MESSAGE: ${err.response?.data['message']}',
      name: 'Log on interceptor',
    );

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }
    return super.onError(err, handler);
  }
}

// class ErrorQueuedInterceptors extends QueuedInterceptorsWrapper {
//   ErrorQueuedInterceptors();
//
//   final Dio dio = Dio();
//
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final service = getIt.get<AuthService>();
//     final accessToken = await service.accessToken();
//     final refreshToken = await service.refreshToken();
//
//     if (accessToken != null && refreshToken != null) {
//       final duration = await service.getAccessTokenRemainingTime();
//       if (duration < 60) {
//         try {
//           final newAccessToken = await dio.get(
//             AppData.env['baseUrl'] + AppData.refreshToken as String,
//             options: Options(
//               headers: {'authorization': refreshToken},
//             ),
//           );
//           if (newAccessToken.statusCode == 200) {
//             options.headers['authorization'] =
//                 "Bearer ${newAccessToken.data['data']['access_token']}";
//             await service.saveAccessToken(
//               newAccessToken.data['data']['access_token'] as String,
//             );
//             await service.saveRefreshToken(
//               newAccessToken.data['data']['refresh_token'] as String,
//             );
//             return handler.next(options);
//           } else {
//             throw DioError(requestOptions: options);
//           }
//         } on DioError catch (e) {
//           return handler.reject(e, true);
//         }
//       } else {
//         options.headers['authorization'] = 'Bearer $accessToken';
//         return handler.next(options);
//       }
//     } else {
//       handler.next(options);
//     }
//   }
// }

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
