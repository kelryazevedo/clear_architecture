import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/errors/errors.dart';
import 'package:clear_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:clear_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:clear_architecture/modules/search/presenter/search/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText{}
main() {
  final usecase = SearchByTextMock();
  // a forma de testar o bloc é diferente porque trabalhamos com os estados dele primeiro, e ai listamos a ordem de estados que esperamos

  final bloc = SearchBlock(usecase);
  test('Deve retornar os estados na ordem correta', () {
    when(usecase("jacob")).thenAnswer((_) async =>Right(<ResultSearch>[]));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchSuccess>()
    ]));
    bloc.add("jacob");
  });

  test('Deve retornar erro', () {
    when(usecase("jacob")).thenAnswer((_) async =>Left(InvalidTextError()));
    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchError>()
    ]));
    bloc.add("jacob");
  });

}
