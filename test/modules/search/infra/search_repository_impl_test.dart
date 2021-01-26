import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/errors/errors.dart';
import 'package:clear_architecture/modules/search/infra/datasources/search_datasource.dart';
import 'package:clear_architecture/modules/search/infra/models/result_search_model.dart';
import 'package:clear_architecture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDataSource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Deve retornar uma lista de ResultSearch', () async {
    // quando o meu datasourch com algum texto retornar (o que ele fará thenAnsewerr) vai retornar um Future do tipo List...
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);
    final result = await repository.search("searchText");
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um erro se o datasource falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());
    final result = await repository.search("searchText");
    expect(result.fold(id,id),isA<DataSourceError>());
  });
}
