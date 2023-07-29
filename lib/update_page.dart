import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdatePage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const UpdatePage({super.key, required this.documentSnapshot});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  CollectionReference product =
      FirebaseFirestore.instance.collection('product');

  @override
  void initState() {
    super.initState();
    namaController.text = widget.documentSnapshot['nama'];
    hargaController.text = widget.documentSnapshot['harga'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: namaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'nama',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: hargaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'harga',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //membuat tombol update
              ElevatedButton(
                  onPressed: () async {
                    final String nama = namaController.text;
                    final int? harga = int.tryParse(hargaController.text);
                    if (nama.isNotEmpty && harga != null) {
                      await product
                          .doc(widget.documentSnapshot.id)
                          .update({'nama': nama, 'harga': harga});
                    }
                    namaController.text = '';
                    hargaController.text = '';
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
              //membuat tombol delete
              ElevatedButton(
                  onPressed: () {
                    product.doc(widget.documentSnapshot.id).delete();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'))
            ],
          )
        ],
      ),
    );
  }
}
