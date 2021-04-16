part of 'upload_noticias_bloc.dart';

abstract class UploadNoticiasEvent extends Equatable {
  const UploadNoticiasEvent();

  @override
  List<Object> get props => [];
}


class PickImageEvent extends UploadNoticiasEvent {
  @override
  List<Object> get props => [];
}

class SaveNewElementEvent extends UploadNoticiasEvent {
  final New noticia;

  SaveNewElementEvent({@required this.noticia});
  @override
  List<Object> get props => [noticia];
}

class SaveApiNewsEvent extends UploadNoticiasEvent {
  final New noticia;

  SaveApiNewsEvent({@required this.noticia});
  @override
  List<Object> get props => [noticia];
}