import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:task_mgmt/src/domain/core/failures/api_auth_failure.dart';
import 'package:task_mgmt/src/domain/core/failures/api_failure.dart';
import 'package:task_mgmt/src/domain/core/internet_service/i_base_client.dart';

@LazySingleton(as: IBaseClient)
class InternetHelper extends IBaseClient {
  InternetHelper(this.client);

  final http.Client client;

  http.Response _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 500:
        if (response.body.contains('message')) {
          return response;
        } else {
          throw ApiFailure(
              message: 'Internal Server Error. Please try again later');
        }
      case 400:
        if (response.body.contains('message')) {
          return response;
        } else {
          throw ApiFailure(
              message:
              'Oops! Something went wrong. Please check your request and try again');
        }
      case 404:
        if (response.body.contains('message')) {
          return response;
        } else {
          throw ApiAuthFailure('Authentication expired');
        }
      default:
        throw ApiFailure(message: 'Something went wrong');
    }
  }

  @override
  Future<http.Response> get(
      {required String url, Map<String, String>? header}) async {
    log(url.toString());
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: header,
      );
      if (response.statusCode == 403) {
        throw ApiFailure(message: "Invalid Credentials!!");
      }
      if (response.body.isEmpty) {
        throw ApiFailure(message: 'No data found');
      }
      return _response(response);
    } on SocketException {
      throw ApiFailure(message: 'No Internet connection');
    } on TimeoutException {
      throw ApiFailure(message: 'Request timed out');
    } catch (e) {
      log(e.toString());
      throw ApiFailure(message: 'An unexpected error occurred');
    }
  }

  @override
  Future<http.Response> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        body: body,
      );
      return _response(response);
    } on SocketException {
      throw ApiFailure(message: 'Internet service not found!');
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message);
    } on TimeoutException {
      throw ApiFailure(message: 'Time out');
    } on ApiAuthFailure catch (_) {
      throw ApiAuthFailure('Api authentication failed');
    } catch (e) {
      throw ApiFailure(message: 'something went wrong !');
    }
  }

  @override
  Future<http.Response> put({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await client.put(
        Uri.parse(url),
        body: body,
      );
      return _response(response);
    } on SocketException {
      throw ApiFailure(message: 'Internet service not found!');
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message);
    } on TimeoutException {
      throw ApiFailure(message: 'Time out');
    } on ApiAuthFailure catch (_) {
      throw ApiAuthFailure('Api authentication failed');
    } catch (e) {
      throw ApiFailure(message: 'something went wrong !');
    }
  }

  @override
  Future<http.Response> delete({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await client.delete(
        Uri.parse(url),
        body: body,
      );
      return _response(response);
    } on SocketException {
      throw ApiFailure(message: 'Internet service not found!');
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message);
    } on TimeoutException {
      throw ApiFailure(message: 'Time out');
    } on ApiAuthFailure catch (_) {
      throw ApiAuthFailure('Api authentication failed');
    } catch (e) {
      throw ApiFailure(message: 'something went wrong !');
    }
  }
}
