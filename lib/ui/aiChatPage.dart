import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:redawn/theme.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> _sendMessage(String question) async {
    if (question.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': question});
      _isLoading = true;
    });

    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('API key is missing or invalid.');
      }
      final prompt =
          "You are MeowMi, a mental therapist pet that gives warm and cute replies to users. "
          "Please respond in a gentle, supportive, and playful tone. Answer the following question:\n\n$question";
      final model =
          GenerativeModel(model: 'models/gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text(prompt)];
      final result = await model.generateContent(content);

      setState(() {
        _messages.add({
          'role': 'ai',
          'content': result.text ?? 'No response from Gemini.'
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'ai', 'content': 'Error: $e'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeowMi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: isUser
                        ? [
                            // Message text for user
                            Flexible(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  message['content'] ?? '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // // User icon placeholder; update the URL as needed
                            // CircleAvatar(
                            //   backgroundImage: NetworkImage(
                            //       'https://via.placeholder.com/150?text=User'),
                            // ),
                          ]
                        : [
                            // AI icon placeholder (cat icon); update the URL as needed
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/CAT AI.png'),
                            ),
                            const SizedBox(width: 8),
                            // Message text for AI
                            Flexible(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  message['content'] ?? '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final question = _messageController.text.trim();
                    _messageController.clear();
                    _sendMessage(question);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
