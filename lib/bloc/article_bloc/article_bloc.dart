import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newapi_bloc/bloc/article_bloc/article_event.dart';
import 'package:newapi_bloc/bloc/article_bloc/article_state.dart';
import 'package:newapi_bloc/models/article_repository.dart';
import 'package:newapi_bloc/models/new_api_model.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({@required this.repository});

  @override
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        ArticleErrorState(message: e.toString());
      }
    }
  }
}
