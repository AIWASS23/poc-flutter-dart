import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zap_zap/services/firestore_service.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _firestoreService = FirestoreService();
  final _messageEditingController = TextEditingController();
  final _listScrollController = ScrollController();
  final double _inputHeight = 60;
  late Stream<QuerySnapshot> _messageStream;

  Stream<QuerySnapshot> _getMessagesStream() {
    return _firestoreService.getMessagesStream(limit: 10);
  }

  Future<void> _addMessage() async {
    try {
      await _firestoreService.addMessage({
        'text': _messageEditingController.text,
        'date': DateTime.now().millisecondsSinceEpoch
      });
      _messageEditingController.clear();
      _listScrollController
          .jumpTo(_listScrollController.position.maxScrollExtent);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to send message'),
          margin: EdgeInsets.only(bottom: _inputHeight),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _messageStream = _getMessagesStream();
  }

  @override
  void dispose() {
    super.dispose();
    _messageEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: const Icon(
            Icons.logout_outlined,
          ),
        ),
      ]),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _messageStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> messagesData = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                      controller: _listScrollController,
                      itemCount: messagesData.length,
                      itemBuilder: (context, index) {
                        final messageData =
                            messagesData[index].data() as Map<String, dynamic>;
                        return MessageCard(
                          messageData: messageData,
                        );
                      }),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    controller: _messageEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_messageEditingController.text != '') {
                      _addMessage();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  MessageCard({Key? key, required this.messageData}) : super(key: key);
  final Map<String, dynamic> messageData;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final senderEmail = messageData['senderEmail'] as String? ?? 'Unknown User';
    final isMyMessage = currentUser?.email == senderEmail;
    final cardColor = isMyMessage ? Colors.deepPurple : Colors.deepOrange;
    final textColor = isMyMessage ? Colors.white : Colors.black;

    return Card(
      color: cardColor,
      child: ListTile(
        title: Text(
          messageData['text'] is String ? messageData['text'] : 'Invalid Message',
          style: TextStyle(
            color: textColor,
          ),
        ),
        subtitle: Text(
          DateFormat('yyyy/MM/dd HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(
              messageData['date'] is int ? messageData['date'] : 0,
            ),
          ),
        ),
      ),
    );
  }
}
