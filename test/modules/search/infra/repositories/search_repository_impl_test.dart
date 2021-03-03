import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/infra/datasources/search_datasourcer.dart';
import 'package:clean_architecture/modules/search/infra/models/result_search_model.dart';
import 'package:clean_architecture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDataSourceMock extends Mock implements SearchDataSource {}

main() {
  final dataSource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(dataSource);

  test('Do have to return a list of ResultSearch', () async {
    when(dataSource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search("Regis");

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Do have to return a error if DataSource fails', () async {
    when(dataSource.getSearch(any)).thenThrow((Exception()));

    final result = await repository.search("Regis");

    expect(result.fold(id, id) , isA<DataSourceError>());
  });
}
