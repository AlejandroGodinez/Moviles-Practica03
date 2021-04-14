part of 'upload_noticias_bloc.dart';

abstract class UploadNoticiasState extends Equatable {
  const UploadNoticiasState();
  
  @override
  List<Object> get props => [];
}

class UploadNoticiasInitial extends UploadNoticiasState {}
class LoadingUploadState extends UploadNoticiasState {}
class PickedImageState extends UploadNoticiasState {
  final File image;

  PickedImageState({@required this.image});
  @override
  List<Object> get props => [image];
}

class SavedNewState extends UploadNoticiasState {
  List<Object> get props => [];
}

class ErrorUploadState extends UploadNoticiasState {
  final String errorMsg;

  ErrorUploadState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}