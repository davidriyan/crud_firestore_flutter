import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/update_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference product =
      FirebaseFirestore.instance.collection('product');

  // TextEditingController namaController = TextEditingController();

  // TextEditingController hargaController = TextEditingController();

  // Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     namaController.text = documentSnapshot['nama'];
  //     hargaController.text = documentSnapshot['harga'].toString();
  //   }
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               left: 20,
  //               right: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: namaController,
  //                 decoration: const InputDecoration(labelText: 'Nama'),
  //               ),
  //               TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 controller: hargaController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'harga',
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               ElevatedButton(
  //                 child: const Text('Update'),
  //                 onPressed: () async {
  //                   final String nama = namaController.text;
  //                   final double? harga = double.tryParse(hargaController.text);
  //                   if (harga != null) {
  //                     await product
  //                         .doc(documentSnapshot!.id)
  //                         .update({"nama": nama, "harga": harga});
  //                     namaController.text = '';
  //                     hargaController.text = '';
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('firestore CRUD'),
      ),
      body: StreamBuilder(
        stream: product.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      documentSnapshot['nama'],
                    ),
                    subtitle: Text(documentSnapshot['harga'].toString()),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return UpdatePage(
                            documentSnapshot: documentSnapshot,
                          );
                        },
                      ));
                    },
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
