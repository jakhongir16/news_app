import 'package:bloc/bloc.dart';
import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:dart_rss/domain/rss_feed.dart';
import 'package:meta/meta.dart';
import 'package:news_bloc/api/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<NewsLoadEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final RssFeed? loadedNews = await newsRepository.getNews(lang: 'ru');
        emit(NewsLoadedState(newsFeed: loadedNews));
      } catch (e) {
        emit(NewsLoadingState());
      }
    });
    on<NewLangUzEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final RssFeed? loadedNews = await newsRepository.getNews(lang: 'uz');
        emit(NewsLoadedState(newsFeed: loadedNews));
      } catch (e) {
        emit(NewsLoadingState());
      }
    });
    on<NewLangEnEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final RssFeed? loadedNews = await newsRepository.getNews(lang: 'en');
        emit(NewsLoadedState(newsFeed: loadedNews));
      } catch (e) {
        emit(NewsLoadingState());
      }
    });
  }
}
