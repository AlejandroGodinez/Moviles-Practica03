import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/home/noticias_ext_api/bloc/search_noticias_bloc.dart';
import 'package:google_login/utils/news_repository.dart';

import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  const NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  final textController = TextEditingController();
  String category = "sports";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchNoticiasBloc, SearchNoticiasState>(
        listener: (context, state) {
      if (state is LoadingSearchNoticias) {
        return ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text("Cargando Noticias")));
      } else if (state is ErrorSearchNoticiasMessageState) {
        return ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text("Ha ocurrido un error ${state.errorMsg}")));
      }
    }, builder: (context, state) {
      if (state is LoadedSearchNoticias) {
        if (state.noticiasList.length == 0) {
          return NoNews(textController: textController);
        } else {
          return SearchedNoticias(
              textController: textController, noticias: state.noticiasList);
        }
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}

class NoNews extends StatelessWidget {
  const NoNews({
    Key key,
    @required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    BlocProvider.of<SearchNoticiasBloc>(context)
                        .add(RequestNewsEvent(query: textController.text));
                  },
                )),
          ),
        ),
        Expanded(
          child: Center(
            child: Text("No news available"),
          ),
        )
      ],
    );
  }
}

class SearchedNoticias extends StatelessWidget {
  const SearchedNoticias(
      {Key key, @required this.textController, @required this.noticias})
      : super(key: key);

  final TextEditingController textController;
  final List noticias;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Buscar',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  BlocProvider.of<SearchNoticiasBloc>(context)
                      .add(RequestNewsEvent(query: textController.text));
                },
              )),
        ),
      ),
      Expanded(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: noticias.length,
          itemBuilder: (context, index) {
            return Center(
                child: Column(
              children: [ItemNoticia(noticia: noticias[index])],
            ));
          },
        ),
      ))
    ]);
  }
}
