import 'dart:async';
import 'package:flutter/foundation.dart'; // For debugPrint, optional
import 'package:http/http.dart' as http;
import 'package:ln_foot/service.dart'; // Or wherever AuthService is

class RefreshingHttpClient extends http.BaseClient { // Implement http.Client by extending BaseClient
  final http.Client _inner;
  final AuthService authService;

  RefreshingHttpClient(this._inner, this.authService);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    debugPrint('RefreshingHttpClient: send() called for ${request.method} ${request.url}');

    // Add initial token
    final String? token = await authService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
      debugPrint('RefreshingHttpClient: Initial token added to request.');
    } else {
      debugPrint('RefreshingHttpClient: No initial token available for request.');
    }

    http.StreamedResponse response;
    try {
      response = await _inner.send(request);
      debugPrint('RefreshingHttpClient: Initial request sent. Status: ${response.statusCode}');
    } catch (e) {
      // This catch block handles errors from the initial _inner.send(request)
      // (e.g., network errors, DNS resolution failures before a response is received)
      debugPrint('RefreshingHttpClient: Error during initial send: $e');
      rethrow; // Rethrow the error if the send itself fails.
    }
    

    if (response.statusCode == 401) {
      debugPrint('RefreshingHttpClient: Received 401, attempting token refresh.');
      // Attempt to refresh the token
      bool refreshed = false; // Initialize to false
      try {
        refreshed = await authService.refreshToken();
      } catch (e) {
        // If authService.refreshToken() itself throws an error (e.g., network issue during refresh)
        debugPrint('RefreshingHttpClient: Error during authService.refreshToken(): $e');
        // In this case, we cannot refresh, so we return the original 401 response.
        // No need to drain the stream of 'response' here as we are returning it directly.
        return response;
      }

      if (refreshed) {
        debugPrint('RefreshingHttpClient: Token refresh reported success.');
        // Get the new token
        final String? newToken = await authService.getAccessToken();
        if (newToken != null && newToken.isNotEmpty) {
          debugPrint('RefreshingHttpClient: New token obtained, updating header and retrying.');
          // Update the request header with the new token
          request.headers['Authorization'] = 'Bearer $newToken';
          
          // It's important to drain the stream of the previous 401 response
          // before making a new request, to free up resources.
          await response.stream.drain(); 
          
          try {
            // Retry the request
            // Note: Sending the same request again. This is generally fine for non-streamed requests
            // or if the stream can be re-read. For simple GET/POST with string/byte bodies, it's okay.
            response = await _inner.send(request);
            debugPrint('RefreshingHttpClient: Retry request sent. Status: ${response.statusCode}');
          } catch (e) {
            // This catch block handles errors from the retry _inner.send(request)
            debugPrint('RefreshingHttpClient: Error during retry send: $e');
            // If the retry fails, rethrow the error. The caller will need to handle it.
            // Alternatively, one might choose to return the original 401 response here too.
            rethrow;
          }
        } else {
          debugPrint('RefreshingHttpClient: Refresh succeeded but new token is null or empty. Returning original 401 response.');
          // If refresh was successful but no new token, return the original 401 response.
          // No need to drain here as we are returning the original response object.
        }
      } else {
        debugPrint('RefreshingHttpClient: Token refresh failed. Returning original 401 response.');
        // If refresh failed, return the original 401 response.
        // No need to drain here as we are returning the original response object.
      }
    }
    return response;
  }

  @override
  void close() {
    debugPrint('RefreshingHttpClient: close() called.');
    _inner.close();
  }

  // No need to override get, post, etc. if `send` handles token appropriately.
  // BaseClient will construct the Request and call your `send` method.
}
