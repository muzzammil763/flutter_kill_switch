import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'kill_switch_dialog.dart';

class KillSwitchService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionPath = 'IAmNothing/NothingInsideMe/WhyAreYouFollowingThisCollection';
  static const String _documentId = 'FlutterKillSwitch';

  /// Initialize the kill switch listener for the app
  static void initializeKillSwitchListener(BuildContext context) {
    _firestore
        .collection(_collectionPath)
        .doc(_documentId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final isKillSwitchEnabled = data['enabled'] as bool? ?? false;
        
        if (isKillSwitchEnabled) {
          _showKillSwitchDialog(context);
        }
      }
    });
  }

  /// Show the kill switch dialog when app is disabled
  static void _showKillSwitchDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: const KillSwitchDialog(),
      ),
    );
  }

  /// Update kill switch state in Firestore
  static Future<void> updateKillSwitchState(bool enabled) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(_documentId)
          .set({'enabled': enabled}, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating kill switch state: $e');
    }
  }

  /// Get current kill switch state
  static Future<bool> getKillSwitchState() async {
    try {
      final doc = await _firestore
          .collection(_collectionPath)
          .doc(_documentId)
          .get();
      
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['enabled'] as bool? ?? false;
      }
      return false;
    } catch (e) {
      debugPrint('Error getting kill switch state: $e');
      return false;
    }
  }
}