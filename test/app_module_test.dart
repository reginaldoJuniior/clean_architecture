import 'dart:convert';

import 'package:clean_architecture/app_module.dart';
import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'modules/search/mockresponses/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  /// Replace Injection dependency by mock class
  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Do have to recovery user case without error', () {
    final useCase = Modular.get<SearchByText>();
    expect(useCase, isA<SearchByTextImpl>());
  });

  test('Do have to bring a list of result source', () async {
    when(dio.get(any)).thenAnswer((realInvocation) async => Response(data: jsonDecode(githubResult), statusCode: 200));

    final useCase = Modular.get<SearchByText>();
    final result = await useCase("regis");

    expect(result | null, isA<List<ResultSearch>>());
  });
}
