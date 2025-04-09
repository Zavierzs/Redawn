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
  int _selectedIndex = 0;

  // Mock data for posts
  final List<Map<String, dynamic>> historyPosts = [
    {
      'title': 'My First Journal',
      'description': 'This is the description for the first journal.',
      'imagePath': 'assets/images/post.jpg',
      'type': 'history',
      'likeCount': 5,
      'commentCount': 2,
    },
    {
      'title': 'A Memorable Day',
      'description': 'This journal talks about a memorable day in my life.',
      'imagePath': 'assets/images/post.jpg',
      'type': 'history',
      'likeCount': 8,
      'commentCount': 3,
    },
  ];

  final List<Map<String, dynamic>> favouritePosts = [
    {
      'title': 'Favourite Journal Entry',
      'description':
          'This is a journal that I really love and keep coming back to.',
      'imagePath': 'assets/images/post.jpg',
      'type': 'favourite',
      'likeCount': 15,
      'commentCount': 7,
    },
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
          NavBar(
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: currentPosts.isEmpty
                ? Center(child: Text('No posts available'))
                : ListView.builder(
                    itemCount: currentPosts.length,
                    itemBuilder: (context, index) {
                      return Post(
                        title: currentPosts[index]['title'] ?? 'No Title',
                        description: currentPosts[index]['description'] ??
                            'No Description',
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
