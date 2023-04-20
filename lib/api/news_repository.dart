import 'package:dart_rss/domain/rss_feed.dart';
import 'package:news_bloc/api/news_api.dart';

class NewsRepository {
  
  Future<RssFeed?> getNews({String? lang}) => NewsApi.getDataRss(lang: lang);
  
}

