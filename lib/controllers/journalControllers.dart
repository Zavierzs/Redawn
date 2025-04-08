import '../models/journalModels.dart';
import '../services/journalServices.dart';

class JournalController {
  final JournalService _service = JournalService();

  Future<void> saveEntry(DateTime selectedDate, String content) async {
    JournalEntry entry = JournalEntry(
      content: content,
      createdAt: selectedDate, // Use the provided selectedDate
    );
    await _service.saveJournalEntry(entry);
  }

  Future<List<JournalEntry>> getEntries() async {
    return await _service.fetchJournalEntries();
  }
}
