abstract class FailureSearch implements Exception{}

class InvalidTextError implements FailureSearch {}

// posso personalizar os erros, coloando mensagens por exemplo
class DataSourceError implements FailureSearch {
  final String message;
  DataSourceError({this.message});
}