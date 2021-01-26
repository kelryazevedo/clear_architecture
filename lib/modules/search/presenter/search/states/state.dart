import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}

class SearchLoading implements SearchState {}

class SearchStart implements SearchState {}
