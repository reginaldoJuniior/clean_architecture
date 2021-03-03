import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository{}

main() {

  final SearchRepository repository = SearchRepositoryMock();
  final useCase = SearchByTextImpl(repository);

  test('Do have to return a list of ResultSearch', () async {
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    final result = await useCase("test");
    expect(result, isA<Right>());
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Do have to return a Exception case the text be invalid', () async {
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await useCase(null);
    expect(result, isA<Left>());
    expect(result | null, null);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await useCase("");
    expect(result.fold(id, id), isA<InvalidTextError>());
  });

}