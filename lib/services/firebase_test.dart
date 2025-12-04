import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTest {
  static Future<void> testConnection() async {
    try {
      print("🔄 Testing Firebase connection...");
      
      // Try to read from your devices collection
      final snapshot = await FirebaseFirestore.instance
          .collection('devices')
          .limit(1)
          .get();
      
      print("✅ Firebase connected successfully!");
      print("📊 Found ${snapshot.docs.length} device(s) in database");
      
      if (snapshot.docs.isNotEmpty) {
        print("📱 First device: ${snapshot.docs.first.data()['name']}");
      }
    } catch (e) {
      print("❌ Firebase connection failed: $e");
    }
  }
}