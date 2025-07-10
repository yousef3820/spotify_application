import 'package:appwrite/appwrite.dart';

class SongAppwriteService {
  final Client client;
  final Databases database;
  final String databaseId;
  final String collectionId;

  SongAppwriteService({
    required this.client,
    required this.databaseId,
    required this.collectionId,
  }) : database = Databases(client);

  Future<List<Map<String, dynamic>>> getNewestSongs() async {
    final result = await database.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: [Query.orderDesc('releaseDate'), Query.limit(4)],
    );
    print(result.documents);
    return result.documents.map((doc) => doc.data).toList();
  }

  Future<List<Map<String, dynamic>>> getPlayList() async {
    final result = await database.listDocuments(
      databaseId: databaseId,
      collectionId: collectionId,
      queries: [Query.orderDesc('releaseDate')],
    );
    print(result.documents);
    return result.documents.map((doc) => doc.data).toList();
  }

  Future<List<Map<String, dynamic>>> searchSongs(String query) async {
  final result = await database.listDocuments(
    databaseId: databaseId,
    collectionId: collectionId,
    queries: [
      Query.or([
        Query.search('title', query),
        Query.search('artist', query),
      ]),
    ],
  );
  return result.documents.map((doc) => doc.data).toList();
}

}
