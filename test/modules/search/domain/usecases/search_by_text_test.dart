import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/errors/errors.dart';
import 'package:clear_architecture/modules/search/domain/repositories/search_repository.dart';
import 'package:clear_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class SearchRepositoryMock extends Mock implements SearchRepository{}


main() {
  // vamos fazer os testes de implementações
  // precisamos mockar o repositorio
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    //usecase("searchText"); como já temos o call no "contrato" não precisa usar "usecase.call"
    final result = await usecase("searchText");
    expect(result, isA<Right>()); //o que eu espero e o que eu passo como parametro
    // Como estamos usando o Either, a gente tem dois parametros, um da direita e outro da esquerda, um excpetion e um ok certo?
    // pra isso utilizamos o isA<Qual eu espero>();
    //expect(result.getOrElse(() => null), isA<List<ResultSearch>>());
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um erro caso o texto seja inválido', () async {
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    var result = await usecase(null);
    expect(result | null, null);
    expect(result.isLeft(), true);
    expect(result.fold(id,id), isA<InvalidTextError>());
    result = await usecase("");
    expect(result.fold(id,id), isA<InvalidTextError>());
  });
}
