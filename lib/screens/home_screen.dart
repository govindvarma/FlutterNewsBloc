import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapi_bloc/bloc/article_bloc/article_bloc.dart';
import 'package:newapi_bloc/bloc/article_bloc/article_event.dart';
import 'package:newapi_bloc/bloc/article_bloc/article_state.dart';
import 'package:newapi_bloc/models/new_api_model.dart';
import 'package:newapi_bloc/screens/about_screen.dart';
import 'package:newapi_bloc/screens/news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticlesEvent());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              navigateToAboutScreen(context);
            },
          ),
        ],
      ),
      body: Container(
        child: BlocListener<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              print('anchit');
              if (state is ArticleInitialState) {
                return buildLoading();
              } else if (state is ArticleLoadingState) {
                return buildLoading();
              } else if (state is ArticleLoadedState) {
                return buildArticleList(state.articles);
              } else if (state is ArticleErrorState) {
                return buildErrorUi(state.message);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[index].urlToImage,
                  child: articles[index].urlToImage != null
                      ? Image.network(
                          articles[index].urlToImage,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              ),
              title: Text(articles[index].title),
              subtitle: Text(articles[index].publishedAt),
            ),
            onTap: () {
              navigateToArticleDetailScreen(context, articles[index]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailScreen(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewsDetailScreen(
        articles: article,
      );
    }));
  }

  void navigateToAboutScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutScreen();
    }));
  }
}
