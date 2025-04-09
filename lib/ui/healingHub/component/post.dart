import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String type;
  final int likeCount;
  final int commentCount;

  Post({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.type,
    required this.likeCount,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(description),
            SizedBox(height: 10),
            // Image or type representation here (optional)
            Image.asset(imagePath),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.thumb_up, size: 20),
                SizedBox(width: 5),
                Text('$likeCount Likes'),
                SizedBox(width: 15),
                Icon(Icons.comment, size: 20),
                SizedBox(width: 5),
                Text('$commentCount Comments'),
                SizedBox(width: 15),
                IconButton(
                  icon: Icon(Icons.share, size: 20),
                  onPressed: () {
                    // Here you can add functionality for sharing
                    print('Post shared!');
                    // For now, it just prints a message in the console
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
