import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/item_button.dart';

/// This is an example todo app with real-time database
/// using Firebase Firestore
class SocialPage extends StatefulWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  /// Initialize a post collection, make sure to use the
  /// right name for the collection as this is
  /// case sensitive.
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
      ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: postsCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Add this to read the document data
                          final data = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // Add this to read the title property
                                  data['title'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  // Add this to read the description property
                                  data['description'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: Text('No items found.'),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ItemButton(
                title: 'New Item',
                color: Colors.green,
                onItemPressed: () {
                  // TODO(joshua): Add button for todo CRUD here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
