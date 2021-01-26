abstract class FailureSearch implements Exception{}

class InvalidTextError implements FailureSearch {}

// forma de personalizar erros de acordo com a necessidade.
class DataSourceError implements FailureSearch {
  final String message;
  DataSourceError({this.message});
}