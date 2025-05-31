import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'looks_model.dart';

enum LookGender { men, women }

class LooksRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<CollectionReference> _getCollection(LookGender gender) async {
    return _firestore.collection(
      gender == LookGender.men ? 'men_generated_looks' : 'women_generated_looks',
    );
  }

  Future<String?> _getLastSeenId(LookGender gender) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_seen_id_${gender.name}');
  }

  Future<void> _setLastSeenId(LookGender gender, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_seen_id_${gender.name}', id);
  }

  Future<List<Look>> fetchNextLooks({required LookGender gender, int limit = 10}) async {
    final collection = await _getCollection(gender);
    final lastSeenId = await _getLastSeenId(gender);

    Query query = collection.orderBy(FieldPath.documentId).limit(limit);

    if (lastSeenId != null && lastSeenId.isNotEmpty) {
      final lastSeenDoc = await collection.doc(lastSeenId).get();
      if (lastSeenDoc.exists) {
        query = query.startAfterDocument(lastSeenDoc);
      }
    }

    final snapshot = await query.get();
    final looks = snapshot.docs.map((doc) => Look.fromFirestore(doc)).toList();

    if (looks.isNotEmpty) {
      await _setLastSeenId(gender, looks.last.id);
    }

    return looks;
  }

  Future<void> resetPagination(LookGender gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_seen_id_${gender.name}');
  }

  Future<void> likeLook(String lookId) async {
    final docRef = _firestore.collection('looks_feedback').doc(lookId);
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.update({'likes': FieldValue.increment(1)});
    } else {
      await docRef.set({'look_id': lookId, 'likes': 1, 'dislikes': 0});
    }
  }

  Future<void> dislikeLook(String lookId) async {
    final docRef = _firestore.collection('looks_feedback').doc(lookId);
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.update({'dislikes': FieldValue.increment(1)});
    } else {
      await docRef.set({'look_id': lookId, 'likes': 0, 'dislikes': 1});
    }
  }

  Future<void> reportLookError(String lookId, LookGender gender) async {
    final docRef = _firestore
        .collection(gender == LookGender.men ? 'men_generated_looks' : 'women_generated_looks')
        .doc(lookId); // TODO: Use gender-based path if needed
    await docRef.update({'errors': FieldValue.increment(1)});
  }
}
