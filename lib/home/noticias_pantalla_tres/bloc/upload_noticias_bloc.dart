import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_noticias_event.dart';
part 'upload_noticias_state.dart';

class UploadNoticiasBloc
    extends Bloc<UploadNoticiasEvent, UploadNoticiasState> {
  final _cFirestore = FirebaseFirestore.instance;
  File _selectedPicture;

  UploadNoticiasBloc() : super(UploadNoticiasInitial());

  @override
  Stream<UploadNoticiasState> mapEventToState(
    UploadNoticiasEvent event,
  ) async* {
    if (event is PickImageEvent) {
      yield LoadingUploadState();
      _selectedPicture = await _getImage();
      yield PickedImageState(image: _selectedPicture);
    } else if (event is SaveApiNewsEvent) {
      yield LoadingUploadState();
      await _saveNoticias(event.noticia);
      yield SavedNewState();
    } else if (event is SaveNewElementEvent) {
      // 1) subir archivo a bucket
      // 2) extraer url del archivo
      // 3) agregar url al elemento de firebase
      // 4) guardar elemento en firebase
      // 5) actualizar lista con RequestAllNewsEvent
      String imageUrl = await _uploadFile();
      if (imageUrl != null) {
        yield LoadingUploadState();
        await _saveNoticias(event.noticia.copyWith(urlToImage: imageUrl));
        // yield LoadedNewsState(noticiasList: await _getNoticias() ?? []);
        yield SavedNewState(); //escuchar por este estado los cambios
      } else {
        yield ErrorUploadState(errorMsg: "No se pudo guardar la imagen");
      }
    }
  }

  // pick image
  Future<File> _getImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<String> _uploadFile() async {
    try {
      var stamp = DateTime.now();
      if (_selectedPicture == null) return null;
      // define upload task
      UploadTask task = FirebaseStorage.instance
          .ref("noticias/imagen_${stamp}.png")
          .putFile(_selectedPicture);
      // execute task
      await task;
      // recuperar url del documento subido
      return await task.storage
          .ref("noticias/imagen_${stamp}.png")
          .getDownloadURL();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("Error al subir la imagen: $e");
      return null;
    } catch (e) {
      // error
      print("Error al subir la imagen: $e");
      return null;
    }
  }

  Future<bool> _saveNoticias(New noticia) async {
    try {
      await _cFirestore.collection("noticias").add(noticia.toJson());
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
