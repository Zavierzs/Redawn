import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/journalModels.dart';

class JournalService {
  final CollectionReference journalCollection =
      FirebaseFirestore.instance.collection('journals');

  Future<void> saveJournalEntry(JournalEntry entry) async {
    await journalCollection.add(entry.toMap());
  }

  Future<List<JournalEntry>> fetchJournalEntries() async {
    QuerySnapshot snapshot =
        await journalCollection.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) {
      return JournalEntry.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
