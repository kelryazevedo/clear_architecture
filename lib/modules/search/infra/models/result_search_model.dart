import 'package:clear_architecture/modules/search/domain/entities/result_search/result_search.dart';

class ResultSearchModel extends ResultSearch {
  String login;
  num id;
  String avatar_url;


  ResultSearchModel(this.login, this.id, this.avatar_url);

  ResultSearchModel.map(Map<String, dynamic> json) {
    this.login = json["login"];
    this.id = json["id"];
    this.avatar_url = json["avatar_url"];
  }
}
