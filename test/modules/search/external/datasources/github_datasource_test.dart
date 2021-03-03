import 'dart:convert';

import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockresponses/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);

  test('Do have to return a list of ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer(
      (_) async => Response(
        data: jsonDecode(githubResult),
        statusCode: 200,
      ),
    );

    final future = datasource.getSearch("searchText");
    expect(future, completes);
  });

  test('Do have to return an Error if the return status code is not 200', () {
    when(dio.get(any)).thenAnswer(
      (realInvocation) async => Response(
        data: null,
        statusCode: 401,
      ),
    );
    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<DataSourceError>()));
  });
}
