part of 'news_bloc.dart';

@immutable
abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final RssFeed? newsFeed;
  const NewsLoadedState({required this.newsFeed});
}
