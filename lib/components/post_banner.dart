import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/models/post.dart';

class PostBanner extends StatelessWidget {
  final VoidCallback onTap;
  final Post post;

  const PostBanner({Key? key, required this.onTap, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade300, Colors.orange.shade700],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: post.imgUrl.startsWith('http') // Verifica si es una URL de internet
                  ? CachedNetworkImage(
                      imageUrl: post.imgUrl,
                      placeholder: (context, url) => CircularProgressIndicator(), // Marcador de posición
                      errorWidget: (context, url, error) => Icon(Icons.error),    // Widget en caso de error
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      post.imgUrl, // Es un asset local
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    post.jaguarName ?? post.subtitle,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}