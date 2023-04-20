import 'package:dart_rss/domain/rss_feed.dart';
import 'package:news_bloc/model/news.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  //https://uzreport.news/feed/rss/ru
  //https://uzreport.news/feed/rss/uz
  static List<News> newsModel = [];
  static RssFeed? rssData;

  static Future<RssFeed?> getDataRss({String? lang}) async {
    final url = Uri.parse('https://uzreport.news/feed/rss/$lang');
    final response = await http.get(url);

    rssData = RssFeed.parse(response.body);
    if (response.statusCode == 200) {
      for (var el in rssData!.items) {
        newsModel.add(
          News(
            title: el.title,
            link: el.link,
            description: el.description,
            date: el.pubDate,
            imageUrl: el.enclosure?.url,
          ),
        );
      }
    } else {
      throw Exception('Error');
    }
    return rssData;
  }
}
