import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/app/data/Destination.dart';

class DestinationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Destination> getDestination(String destinationId) async {
    try {
      // Get the document from Firestore by ID
      DocumentSnapshot doc = await _firestore.collection('destinations').doc(destinationId).get();

      // Convert the document into a Destination object
      if (doc.exists) {
        return Destination.fromFirestore(doc);
      } else {
        throw Exception('Destination not found');
      }
    } catch (e) {
      throw Exception('Error fetching destination: $e');
    }
  }
}
