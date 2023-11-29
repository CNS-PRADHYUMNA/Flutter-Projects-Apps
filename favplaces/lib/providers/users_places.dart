import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDB() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'Places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, img TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDB();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['img'] as String),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File img) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    final filename = path.basename(img.path);

    final cimg = await img.copy('${appDir.path}/$filename');
    final newplace = Place(title: title, image: cimg);

    final db = await _getDB();
    db.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'img': newplace.image.path,
    });

    state = [...state, newplace];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
