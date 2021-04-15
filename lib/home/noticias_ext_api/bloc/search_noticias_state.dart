part of 'search_noticias_bloc.dart';

abstract class SearchNoticiasState extends Equatable {
  const SearchNoticiasState();
  
  @override
  List<Object> get props => [];
}

class SearchNoticiasInitial extends SearchNoticiasState {}
class LoadingSearchNoticias extends SearchNoticiasState {}
class LoadedSearchNoticias extends SearchNoticiasState {
  final List<New> noticiasList;

  LoadedSearchNoticias({@required this.noticiasList});
  @override
  List<Object> get props => [noticiasList];
}

class ErrorSearchNoticiasMessageState extends SearchNoticiasState {
  final String errorMsg;

  ErrorSearchNoticiasMessageState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
