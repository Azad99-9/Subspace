import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:subspace/model/article.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Article>> fetchArticles() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=d1ef20d754254f7eae44fe1883303dba');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articlesJson = data['articles'];

      List<Article> articles = [];
      for (var articleJson in articlesJson) {
        try {
          Article article = Article.fromJson(articleJson);
          articles.add(article);
        } catch (e) {
          print('Error parsing article: $e');
        }
      }

      return articles;
    } else {
      print('API Call Failed with Status Code: ${response.statusCode}');
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Latest News!!🔥🔥',
            style: GoogleFonts.inclusiveSans(fontWeight: FontWeight.w800),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Article>>(
            future: fetchArticles(),
            builder: (context, snapshot) {
              // print(snapshot.data)
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                print(snapshot.data);
                List<Article>? articles = snapshot.data;
                if (articles == null) {
                  return Text('No data');
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children:
                          List.generate(snapshot.data?.length ?? 0, (index) {
                        return ThumbnailCard(
                          article: articles[index],
                        ); // Replace with your desired widget
                      }),
                    ),
                  );
                }
              }
            },
          ),
        ));
  }
}

class ThumbnailCard extends StatelessWidget {
  ThumbnailCard({super.key, required this.article});

  Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey, // Color of the shadow
                offset:
                    Offset(0, 3), // Offset of the shadow (horizontal, vertical)
                blurRadius: 5, // Blur radius of the shadow
                spreadRadius: 0, // Spread radius of the shadow
              ),
            ],
            image: DecorationImage(
                image: NetworkImage(article.imageurl), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                article.paperName,
                style: GoogleFonts.inclusiveSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 4),
            //   decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
            //   child: ),
            SizedBox(
              height: 80,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    child: Text(
                      article.title,
                      style: GoogleFonts.inclusiveSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    height: 70,
                    child: Text(
                      article.description,
                      style: GoogleFonts.inclusiveSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          article.authorName,
                          style: GoogleFonts.inclusiveSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        article.date,
                        style: GoogleFonts.inclusiveSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 8),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class DescriptionCard extends StatelessWidget {
//   const DescriptionCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Text('Pname'),
//           Text('published At'),
//           Image(
//             image: NetworkImage(''),
//           ),
//           Row(
//             children: [
//               Text('Title'),
//               Text('autbor name'),
//             ],
//           ),
//           Text('Description'),
//           Text('Content'),
//           TextButton(
//             child: Text('go to page'),
//             onPressed: () {},
//           )
//         ],
//       ),
//     );
//   }
// }
