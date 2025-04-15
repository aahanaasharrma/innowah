import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> _articles = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews({String? query}) async {
    final String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
    String url = 'https://newsapi.org/v2/everything?q=environment%20sustainability&apiKey=$apiKey';

    if (query != null && query.isNotEmpty) {
      url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        final List<dynamic>? articles = data?['articles'];
        if (articles != null) {
          setState(() {
            _articles = articles.map((article) => Article.fromJson(article)).toList();
          });
        } else {
          throw Exception('No articles found');
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  void _onSearchTextChanged(String query) {
    _fetchNews(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Text(
              'Eco News',
              style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchTextChanged,
                decoration: InputDecoration(
                  hintText: 'Search News',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(Uri.encodeFull(article.url));

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch ${article.url}';
                      }
                    },

                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.description),
                        leading: article.imageUrl.isNotEmpty
                            ? Image.network(
                          article.imageUrl,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                            : Container(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
    );
  }
}
