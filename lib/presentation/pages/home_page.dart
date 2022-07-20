import 'package:flutter/material.dart';
import 'package:kopelindo/core/utils/utils.dart';
import 'package:kopelindo/presentation/models/models.dart';
import 'dart:convert';

import 'package:kopelindo/presentation/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  List<Pengajuan> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Pengajuan')),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPage()),
                ).then((value) => _getData());
              },
              child: const Text('Tambah'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Plafon: Rp ${data[index].plafon}'),
                        Text('Tenor: ${data[index].tenor} tahun'),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditPage(id: data[index].id!, plafon: data[index].plafon!, tenor: data[index].tenor!)),
                                ).then((value) => _getData());
                              },
                              child: const Text('Edit'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                _deleteData(data[index].id);
                                _getData();
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getData() async {
    data = [];
    setState(() {
      _isLoading = true;
    });

    var res = await Network().getData('/pengajuan/list');
    if(res.statusCode == 200){
      for (Map<String, dynamic> item in json.decode(res.body)) {
        data.add(Pengajuan.fromJson(item));
      }
    }

    setState(() {
      _isLoading = false;
    });

    return data;
  }

  _deleteData(id) async {
    await Network().deleteData('/pengajuan/delete/${id}');
  }
}
