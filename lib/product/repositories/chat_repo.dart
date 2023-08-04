
abstract class ChatRepository {

    Stream<List<Map<String, dynamic>>> getMessages({required String chatId});
    Future<void> sendMessage({required String chatId, required String message});
    Future<void> deleteMessage({required String chatId, required String messageId});
    Future<void> deleteChat({required String chatId});
    Future<void> deleteAllMessages({required String chatId});
    Future<void> deleteAllChats();
}