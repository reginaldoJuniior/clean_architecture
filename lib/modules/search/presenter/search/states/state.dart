import 'package:clean_architecture/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess extends SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchLoading extends SearchState {}

class SearchStart extends SearchState {}

class SearchError extends SearchState {
  final FailureSearch erro;

  SearchError(this.erro);
}
