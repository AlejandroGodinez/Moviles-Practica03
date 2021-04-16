import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';

class ItemNoticia extends StatelessWidget {
  final New noticia;
  final String urlImg =
      'https://lexfe.com.ar/wp-content/uploads/2016/04/dummy-post-horisontal.jpg';
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// Cambiar image.network por Extended Image con place holder en caso de error o mientras descarga la imagen
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  "${noticia.urlToImage ?? urlImg}",
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${noticia.title}",
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${noticia.publishedAt}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.description ?? "Descripcion no disponible"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "${noticia.author ?? "Autor no disponible"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            label: Text("Compartir",
                                style: TextStyle(color: Colors.white)),
                            icon: Icon(Icons.share_outlined, color: Colors.white),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              print("compartir");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
