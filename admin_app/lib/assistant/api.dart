import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../controllers/accounts_controllers/refresh_controller.dart';
import 'api_exception.dart';

class Api {
  Future<dynamic> get({required String url, String? token}) async {
    return await handleWithRefresh(
      (usedToken) async {
        final headers = {
          'Accept': 'application/json',
          if (usedToken.isNotEmpty) 'Authorization': 'Bearer $usedToken',
        };
        return http.get(Uri.parse(url), headers: headers);
      },
      'GET',
      token,
    );
  }

  Future<dynamic> post({
    required String url,
    dynamic body,
    String? token,
  }) async {
    return await handleWithRefresh(
      (usedToken) async {
        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (usedToken.isNotEmpty) 'Authorization': 'Bearer $usedToken',
        };
        return http.post(
          Uri.parse(url),
          headers: headers,
          body: body is String ? body : jsonEncode(body),
        );
      },
      'POST',
      token,
    );
  }

  Future<dynamic> postForm({
    required String url,
    required Map<String, String> fields,
    String? token,
  }) async {
    return await handleWithRefresh(
      (usedToken) async {
        final headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          if (usedToken.isNotEmpty) 'Authorization': 'Bearer $usedToken',
        };
        return http.post(Uri.parse(url), headers: headers, body: fields);
      },
      'POST Form',
      token,
    );
  }

  Future<dynamic> postMultipart({
    required String url,
    required Map<String, String> fields,
    required Map<String, String> files,
    String? token,
  }) async {
    return await handleWithRefresh(
      (usedToken) async {
        final request = http.MultipartRequest('POST', Uri.parse(url));

        request.headers['Accept'] = 'application/json';
        if (usedToken.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $usedToken';
        }

        request.fields.addAll(fields);

        for (final entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value,
              filename: entry.value.split('/').last,
            ),
          );
        }

        final streamedResponse = await request.send();
        return http.Response.fromStream(streamedResponse);
      },
      'Multipart',
      token,
    );
  }

  Future<dynamic> put({
    required String url,
    Map<String, String>? fields,
    String? token,
  }) async {
    final effectiveFields = {...?fields, '_method': 'PUT'};
    return postForm(url: url, fields: effectiveFields, token: token);
  }

  Future<dynamic> delete({required String url, String? token}) async {
    return await handleWithRefresh(
      (usedToken) async {
        final headers = {
          'Accept': 'application/json',
          if (usedToken.isNotEmpty) 'Authorization': 'Bearer $usedToken',
        };
        return http.delete(Uri.parse(url), headers: headers);
      },
      'DELETE',
      token,
    );
  }

  Future<dynamic> patch({
    required String url,
    Map<String, String>? fields,
    String? token,
  }) async {
    return await handleWithRefresh(
      (usedToken) async {
        final headers = {
          'Accept': 'application/json',
          if (usedToken.isNotEmpty) 'Authorization': 'Bearer $usedToken',
        };
        return http.patch(Uri.parse(url), headers: headers, body: fields);
      },
      'PATCH',
      token,
    );
  }

  Future<dynamic> handleWithRefresh(
    Future<http.Response> Function(String token) requestFn,
    String method, [
    String? directToken,
  ]) async {
    final refreshController = Get.find<RefreshController>();
    final token = directToken ?? refreshController.token.value;

    http.Response response = await requestFn(token);

    if (directToken == null &&
        response.statusCode == 401 &&
        token.isNotEmpty) {
      final newToken = await refreshController.refreshToken(token);
      if (newToken != null && newToken.isNotEmpty) {
        response = await requestFn(newToken);
      }
    }

    return handleResponse(response, method);
  }

  dynamic handleResponse(http.Response response, String method) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decodeResponse(response.body);
    } else {
      final decoded = decodeResponse(response.body);
      final message = decoded is Map<String, dynamic>
          ? (decoded['message'] ?? decoded['error'] ?? response.body)
          : response.body;
      throw ApiException(response.statusCode, '$method failed → $message');
    }
  }

  dynamic decodeResponse(String body) {
    if (body.isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is List) return decoded;
      return {'raw': decoded};
    } catch (_) {
      return {'raw': body};
    }
  }
}
