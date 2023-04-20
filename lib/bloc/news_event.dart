part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {
  const NewsEvent();
}

class NewsLoadEvent extends NewsEvent {
  const NewsLoadEvent();
}



class NewLangUzEvent extends NewsEvent {
  const NewLangUzEvent();
}

class NewLangEnEvent extends NewsEvent {
  const NewLangEnEvent();
}