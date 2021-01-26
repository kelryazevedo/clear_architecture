import 'dart:convert';

import 'package:clear_architecture/modules/search/domain/errors/errors.dart';
import 'package:clear_architecture/modules/search/external/datasources/github_datasource.dart';
import 'package:clear_architecture/modules/search/utils/github_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio{}

main() {
  final dio = DioMock();
  final datasource = GithubDataSource(dio);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String _githubResult = encoder.convert(githubResult);
    // aqui vamos simular a chamada na api
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(_githubResult),statusCode: 200)); // o Response e o status code é padrão do DIO mesmo pra requisição quando funciona.
    final future = datasource.getSearch("searchText");
    // nesse caso não me importa se é vazio ou não, o que importa é se ela completou a requisição
    expect(future, completes);
    
  });

  test('Deve retornar um erro se o código não for 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: null,statusCode: 401)); // Possiveis erros de services.
    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<DataSourceError>()));
  });

  test('Deve retornar um Exception se tiver erro no Dio', () async {
    when(dio.get(any)).thenThrow(Exception()); // Possiveis erros de services.
    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<Exception>()));
  });
}