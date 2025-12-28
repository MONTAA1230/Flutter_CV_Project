import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCustomService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createData(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    await _db.collection(collection).doc(docId).set(data);
  }

  // await FirebaseCustomService().createData('users', 'Example@gmail.com',{'name': 'Skandar', 'city': 'Sfax'});
  //###############################################################################################

  Future<void> updateData(
    String collection,
    String docId,
    Map<String, dynamic> updates,
  ) async {
    await _db.collection(collection).doc(docId).update(updates);
  }

  // await FirebaseCustomService().updateData('users', 'Example@gmail.com', {'city': 'Tunis'});
  //###############################################################################################

  Future<void> deleteData(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
  }
  // await FirebaseCustomService().deleteData('users', 'Example@gmail.com');
  //###############################################################################################

  Future<List<Map<String, dynamic>>> getAll(String collection) async {
    QuerySnapshot query = await _db.collection(collection).get();
    return query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // List<Map<String, dynamic>> allUsers = await FirebaseCustomService().getAll('users');
  // print(allUsers);
  // We Get all the docs here !
  //###############################################################################################

  Future<Map<String, dynamic>?> getAllFromDoc(
    String collection,
    String docId,
  ) async {
    DocumentSnapshot doc = await _db.collection(collection).doc(docId).get();
    return doc.data() as Map<String, dynamic>?;
  }

  // var userData = await FirebaseCustomService().getAllFromDoc('users', 'Example@gmail.com');
  // print(userData?['education']);
  // We Get only a specific doc here !

  Future<void> deleteWhere({
    required String collection,
    required Map<String, dynamic> whereEquals,
  }) async {
    Query query = FirebaseFirestore.instance.collection(collection);

    whereEquals.forEach((field, value) {
      query = query.where(field, isEqualTo: value);
    });

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) return;

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  // await deleteWhere(
  //   collection: 'users',
  //   whereEquals: {
  //     'adresse': 'Rte. Ain Km 1.5, Sfax',
  //   },
  // );
  Future<void> addDataToFirebase() async {
    await _db.collection('users').doc('montassarbenhariz90@gmail.com').set({
      'description':
          'Diplômé en Génie Informatique, passionné par l’intelligence artificielle, le deep learning et le data mining. Rigoureux, curieux et motivé, je souhaite contribuer à des projets innovants et mettre mes compétences techniques au service d’une entreprise ambitieuse.',
      'education': [
        {
          'year': '2022 - Présent',
          'place': 'IIT',
          'diploma': 'Génie Informatique | Sfax',
        },
        {
          'year': '2019 - 2022',
          'place': 'FSEG',
          'diploma': 'Programme d\'Informatique Appliquée à la Gestion | Sfax',
        },
        {
          'year': '2019',
          'place': 'Lycée 15 Novembre 1955',
          'diploma': 'Baccalauréat en Sciences Expérimentales | Sfax',
        },
      ],
      'formation': [
        {
          'platform': 'Udemy',
          'title': 'Flutter development bootcamp with Dart',
          'year': '2020',
          'color': '0xffFFABC8',
        },
        {
          'platform': 'Udemy',
          'title': 'Formation Complète Développeur Web',
          'year': '2019',
          'color': '0xff7768D8',
        },
        {
          'platform': 'Udemy',
          'title': 'Formation Complète Développeur Web',
          'year': '2019',
          'color': '0xff7768D8',
        },
        {
          'platform': 'Udemy',
          'title': 'Formation Complète Développeur Web',
          'year': '2019',
          'color': '0xff7768D8',
        },
      ],
      'experience': [
        {
          'role': 'Freelancer',
          'domain': 'Flutter & DevOps',
          'period': '2020 - Présent',
        },
      ],
      'competence': [
        {
          'image': 'assets/images/html.png',
          'name': 'HTML',
          'color': '0xffFFA500',
        },
        {
          'image': 'assets/images/css.png',
          'name': 'CSS',
          'color': '0xff87CEEB',
        },
        {
          'image': 'assets/images/js.png',
          'name': 'JavaScript',
          'color': '0xffFFD700',
        },
        {
          'image': 'assets/images/bs.png',
          'name': 'BootStrap',
          'color': '0xff9370DB',
        },
      ],
      'langue': [
        {'name': 'Arabe', 'level': 'Native'},
        {'name': 'Français', 'level': 'Conversational'},
        {'name': 'Anglais', 'level': 'Conversational'},
      ],
      'adresse': 'Rte. Ain Km 1.5, Sfax',
      'phone': '+216 93 519 879',
      'email': 'montassarbenhariz90@gmail.com',
    });
  }
}
