import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';
import 'package:clear_architecture/modules/search/domain/usecases/search_by_text.dart';
import 'package:clear_architecture/modules/search/presenter/search/states/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

//passa como parametro a entrada do método e depois o estado dele
class SearchBlock extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBlock(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
    yield SearchLoading();
    final result = await usecase(searchText);
    yield result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }

  // esse cara aqui faz um intervalo entre as chamadas no back enquanto é digitada cada letra para diminuir bind.
  @override
  Stream<Transition<String, SearchState>> transformEvents(Stream<String> events,TransitionFunction<String, SearchState> transitionFn) {
      return super.transformEvents(events.debounceTime(Duration(milliseconds: 800)),transitionFn);
  }
}
