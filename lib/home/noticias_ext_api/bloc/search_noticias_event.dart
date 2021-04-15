part of 'search_noticias_bloc.dart';

abstract class SearchNoticiasEvent extends Equatable {
  const SearchNoticiasEvent();

  @override
  List<Object> get props => [];
}

//hacer request a NewsApi con el query por default de sports
class RequestSportsNewsEvent extends SearchNoticiasEvent{
  @override 
  List<Object> get props => [];
}

//hacer request a NewsApi con el query de input
class RequestNewsEvent extends SearchNoticiasEvent{
  final String query;

  RequestNewsEvent({@required this.query});

  @override 
  List<Object> get props => [query];
}

