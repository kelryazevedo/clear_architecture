import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/errors/errors.dart';
import 'package:clear_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

// por mais que pareça repetitivo, a ideia de usar os dois métodos, é sempre usar uma abstração e não a implementação direta em casos de alterações
abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchtext);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchtext) async {
    if (searchtext == null || searchtext.isEmpty) return Left(InvalidTextError());

    return repository.search(searchtext);
  }
}
