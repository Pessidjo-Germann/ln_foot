// import 'package:dio/dio.dart';
// import '../service.dart';

// class AuthInterceptor extends Interceptor {
//   final AuthService authService;

//   AuthInterceptor(this.authService);

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await authService.getAccessToken();
//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401) {
//       final refreshed = await authService.refreshToken();
//       if (refreshed) {
//         final newToken = await authService.getAccessToken();
//         err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
//         final cloneReq = await Dio().fetch(err.requestOptions);
//         return handler.resolve(cloneReq);
//       }
//     }
//     handler.next(err);
//   }
// }
