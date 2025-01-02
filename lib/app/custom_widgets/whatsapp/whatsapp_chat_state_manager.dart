import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'dart:async'; // For polling functionality

class ChatStateManager extends ChangeNotifier {
  List<ChatMessage> chatMessages = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  final String user1Id;
  final String user2Id;
  final Future<List<ChatMessage>> Function() fetchMessages;
  final Future<void> Function(ChatMessage) sendMessage;

  ChatStateManager({
    required this.user1Id,
    required this.user2Id,
    required this.fetchMessages,
    required this.sendMessage,
  });

  Timer? _pollingTimer;

  /// Initializes the state manager
  void initialize() async {
    await _loadMessages();

    // Start polling
    _startPolling();
  }

  Future<void> _loadMessages({bool initialLoad = false}) async {
    try {
      if (initialLoad) {
        isLoading = true;
        notifyListeners();
      }

      final newMessages = await fetchMessages();

      chatMessages.clear();
      // Use a combination of user.id, createdAt, and text to identify unique messages
      final existingMessages = chatMessages.map((m) => '${m.user.id}:${m.createdAt}:${m.text}').toSet();
      final messagesToAdd = newMessages.where((m) => !existingMessages.contains('${m.user.id}:${m.createdAt}:${m.text}')).toList();

      if (messagesToAdd.isNotEmpty) {
        chatMessages.insertAll(0, messagesToAdd); // Insert at the top
        notifyListeners();
      }

      isLoading = false;
      hasError = false;
    } catch (e) {
      isLoading = false;
      hasError = true;
      errorMessage = 'Failed to load messages: $e';
      notifyListeners();
    }
  }

  /// Send a new message and add it to the chat
  Future<void> sendNewMessage(ChatMessage message) async {
    try {
      await sendMessage(message);
      chatMessages.insert(0, message); // Add new message to the start
      notifyListeners();
    } catch (e) {
      hasError = true;
      errorMessage = 'Failed to send message: $e';
      notifyListeners();
    }
  }

  /// Poll messages periodically
  void _startPolling() {
    _pollingTimer?.cancel(); // Cancel any existing timer
    _pollingTimer = Timer.periodic(const Duration(seconds: 15), (_) async {
      await _loadMessages();
    });
  }

  /// Dispose and clean up
  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

}
