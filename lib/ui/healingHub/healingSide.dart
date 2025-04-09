import 'package:flutter/material.dart';
import 'component/navbar.dart';
import 'component/post.dart';

class HealingSide extends StatefulWidget {
  final String title;

  HealingSide({required this.title});

  @override
  _HealingSideState createState() => _HealingSideState();
}

class _HealingSideState extends State<HealingSide> {
  int _selectedIndex = 0; // 0 = History, 1 = Favourites

  final List<Map<String, dynamic>> historyPosts = [
    // Add your history posts here...
  ];

  final List<Map<String, dynamic>> favouritePosts = [
    // Add your favourite posts here...
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> currentPosts =
        _selectedIndex == 0 ? historyPosts : favouritePosts;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Passing the onTabChange callback to NavBar
          NavBar(
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentPosts.length,
              itemBuilder: (context, index) {
                return Post(
                  title: currentPosts[index]['title'] ?? 'No Title',
                  description:
                      currentPosts[index]['description'] ?? 'No Description',
                  imagePath: currentPosts[index]['imagePath'] ??
                      'assets/images/post.jpg',
                  type: currentPosts[index]['type'] ?? '',
                  likeCount: currentPosts[index]['likeCount'],
                  commentCount: currentPosts[index]['commentCount'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
