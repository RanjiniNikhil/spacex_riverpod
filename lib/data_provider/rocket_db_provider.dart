import 'package:path/path.dart';
import 'package:spacex_riverpod/models/rocket_response_model.dart';
import 'package:sqflite/sqflite.dart';

class RocketDBProvider {
  static const int _version = 1;
  static const String _dbName = "Rockets.db";
  static const String _dbImageName = "Images.db";

  static Future<Database> _getDB() async {
    await _getImageDB();
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE ROCKETS (id TEXT PRIMARY KEY, name TEXT, country TEXT, enginesNumber INT, active INT, cost_per_launch INT, success_rate_pct INT, wikipedia TEXT, description TEXT, heightMeters REAL, heightFeet REAL,diameterMeters REAL,diameterFeet REAL)'),
        version: _version);
  }

  static Future<Database> _getImageDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbImageName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE IMAGES (id TEXT PRIMARY KEY, rocketId TEXT, flickr_images TEXT)'),
        version: _version);
  }

  static Future<int> addImage(String id, String image) async {
    final imageDb = await _getImageDB();
    return await imageDb.insert(
        "IMAGES", {'rocketId': id, 'flickr_images': image},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static addFlickerImage(List<String> image, String id) async {
    for (int i = 0; i < image.length; i++) {
      await addImage(id, image[i]);
    }
  }

  static Future<int> addRocket(RocketResponseModel rocket) async {
    addFlickerImage(rocket.flickrImages, rocket.id);
    final db = await _getDB();
    return await db.insert(
        "ROCKETS",
        {
          'id': rocket.id,
          'name': rocket.name,
          'country': rocket.country,
          'enginesNumber': rocket.engines.number,
          'active': rocket.active,
          'cost_per_launch': rocket.costPerLaunch,
          'success_rate_pct': rocket.successRatePct,
          'wikipedia': rocket.wikipedia,
          'description': rocket.description,
          'heightMeters': rocket.height.meters,
          'heightFeet': rocket.height.feet,
          'diameterMeters': rocket.diameter.meters,
          'diameterFeet': rocket.diameter.feet
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteAllRockets() async {
    final db = await _getDB();
    final res = await db.rawDelete('DELETE FROM ROCKETS');
    print("data is deleted from rockets table");
    return res;
  }

  static Future<List<String>> getImages(String id) async {
    final db = await _getImageDB();
    final res = await db.rawQuery("SELECT * FROM IMAGES");
    List<ImageModel> list = res
        .map((e) => ImageModel(
            id: e['id'].toString(),
            rocketId: e['rocketId'].toString(),
            flickerImage: e['flickr_images'].toString()))
        .toList();
    List<String> responseList = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].rocketId == id) {
        responseList.add(list[i].flickerImage);
      }
    }
    return responseList;
  }

  static Future<RocketResponseModel> getRocketDetails(String id) async {
    List<String> flickerImages = await getImages(id);
    final db = await _getDB();
    final res = await db.rawQuery("SELECT * FROM ROCKETS");
    List<RocketResponseModel> list = res
        .map((c) => RocketResponseModel(
            name: c['name'].toString(),
            country: c['country'].toString(),
            engines: EnginesItemModel(
                number: int.parse(c['enginesNumber'].toString())),
            flickrImages: flickerImages,
            active: int.parse(c['active'].toString()) == 0 ? false : true,
            costPerLaunch: int.parse(c['cost_per_launch'].toString()),
            successRatePct: int.parse(c['success_rate_pct'].toString()),
            wikipedia: c['wikipedia'].toString(),
            description: c['description'].toString(),
            id: c['id'].toString(),
            height: DiameterItemModel(
                meters: double.parse(c['heightMeters'].toString()),
                feet: double.parse(c['heightFeet'].toString())),
            diameter: DiameterItemModel(
                meters: double.parse(c['diameterMeters'].toString()),
                feet: double.parse(c['diameterFeet'].toString()))))
        .toList();
    late RocketResponseModel response;
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        response = list[i];
      }
    }
    return response;
  }
}
