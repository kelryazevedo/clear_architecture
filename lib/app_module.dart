import 'package:clear_architecture/app_widget.dart';
import 'package:clear_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:clear_architecture/modules/search/presenter/search/search_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/search/domain/usecases/search_by_text.dart';
import 'modules/search/external/datasources/github_datasource.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';

class AppModule extends MainModule{

  @override
  List<Bind> get binds => [
    // dependency injection

    Bind((i) => Dio()),
    Bind((i) => SearchByTextImpl(i())),
    Bind((i) => GithubDataSource(i())),
    Bind((i) => SearchRepositoryImpl(i())),
    Bind((i) => SearchBlock(i())),
  ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SearchPage()),
  ];


}