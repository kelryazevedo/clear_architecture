import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/errors/errors.dart';
import 'package:clear_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:clear_architecture/modules/search/infra/datasources/search_datasource.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DataSourceError catch (error) { // o erro que o cara vá querer tratar
      return Left(error);
    } catch (e) {
      return Left(DataSourceError());// se for um erro desconhecido ele retorna
    }
  }
}
