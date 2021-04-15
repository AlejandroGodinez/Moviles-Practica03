import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_login/utils/news_repository.dart';
import 'package:google_login/models/new.dart';

part 'search_noticias_event.dart';
part 'search_noticias_state.dart';

class SearchNoticiasBloc extends Bloc<SearchNoticiasEvent, SearchNoticiasState> {
  //traer las noticias disponibles en base a su query
  final noticias = NewsRepository();
  SearchNoticiasBloc() : super(SearchNoticiasInitial());

  @override
  Stream<SearchNoticiasState> mapEventToState(
    SearchNoticiasEvent event,
  ) async* {
    if(event is RequestSportsNewsEvent){
      yield LoadingSearchNoticias();
      yield LoadedSearchNoticias(noticiasList: await noticias.getAvailableNoticias("sports"));
    } else if(event is RequestNewsEvent){
      yield LoadedSearchNoticias(noticiasList: await noticias.getAvailableNoticias(event.query));
    }
    
  }
}
