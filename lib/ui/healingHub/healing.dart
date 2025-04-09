import 'package:flutter/material.dart' hide SearchBar;
import 'component/searchbar.dart';
import 'component/post.dart';

class HealingHub extends StatelessWidget {
  final List<Map<String, dynamic>> posts = [
    {
      'title': 'Mental Wellness Journey',
      'description':
          'A guided series to improve your mental health and well-being.',
      'type': 'Podcast',
      'likeCount': 10,
      'commentCount': 5,
    },
    {
      'title': 'Overcoming Anxiety',
      'description': 'Practical tips to manage anxiety and find calm.',
      'type': 'Podcast',
      'likeCount': 20,
      'commentCount': 8,
    },
    {
      'title': 'Building Resilience',
      'description':
          'Learn strategies for building emotional strength and resilience.',
      'type': 'Podcast',
      'likeCount': 18,
      'commentCount': 6,
    },
    {
      'title': 'Mindfulness Meditation',
      'description':
          'A simple meditation practice to quiet the mind and relax.',
      'type': 'Music',
      'likeCount': 30,
      'commentCount': 15,
    },
    {
      'title': 'Self-Care Rituals',
      'description':
          'Incorporating self-care into your daily routine for a balanced life.',
      'type': 'Article',
      'likeCount': 25,
      'commentCount': 10,
    },
    {
      'title': 'Positive Affirmations',
      'description': 'Empowering words to uplift your spirit and mind.',
      'type': 'Podcast',
      'likeCount': 30,
      'commentCount': 12,
    },
    {
      'title': 'Dealing with Depression',
      'description': 'Steps to overcome feelings of sadness and hopelessness.',
      'type': 'Article',
      'likeCount': 28,
      'commentCount': 9,
    },
    {
      'title': 'Mindful Breathing',
      'description': 'Using breathwork to ground yourself and release stress.',
      'type': 'Music',
      'likeCount': 35,
      'commentCount': 20,
    },
    {
      'title': 'Mental Health Awareness',
      'description':
          'Breaking the stigma and advocating for mental health support.',
      'type': 'Article',
      'likeCount': 40,
      'commentCount': 22,
    },
    {
      'title': 'Overcoming Burnout',
      'description':
          'Practical strategies to recover from emotional and mental exhaustion.',
      'type': 'Podcast',
      'likeCount': 38,
      'commentCount': 18,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: SearchBar()),
                IconButton(
                  icon: Icon(Icons.document_scanner, color: Colors.teal),
                  onPressed: () {
                    Navigator.pushNamed(context, '/healingSide');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Post(
                  title: posts[index]['title']!,
                  description: posts[index]['description']!,
                  imagePath: 'assets/images/post.jpg',
                  type: posts[index]['type'] ?? '',
                  likeCount: posts[index]['likeCount'],
                  commentCount: posts[index]['commentCount'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
