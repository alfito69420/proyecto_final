import 'package:flutter/material.dart';
import 'package:proyecto_final/components/post_banner.dart';
import 'package:proyecto_final/models/post.dart';
import 'package:proyecto_final/screens/general/post_screen.dart';
import 'package:proyecto_final/settings/theme_settings.dart';

class PostsListScreen extends StatelessWidget {
  final List<Post> posts;

  const PostsListScreen({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias del Santuario'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Theme.of(context).scaffoldBackgroundColor,
                    ThemeSettings.generateSimilarColorHSL(Theme.of(context).scaffoldBackgroundColor)],
          ),
        ),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: PostBanner(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(
                        post: posts[index],
                      ),
                    ),
                  );
                },
                post: posts[index],
              ),
            );
          },
        ),
      ),
    );
  }
}