import 'package:flutter/material.dart';
import 'package:kopelindo/core/utils/utils.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  var plafon;
  var tenor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tambah Pengajuan'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Plafon',
                    ),
                    validator: (plafonValue) {
                      if (plafonValue!.isEmpty) {
                        return 'Please enter plafon';
                      }
                      plafon = plafonValue;
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Tenor',
                    ),
                    validator: (tenorValue) {
                      if (tenorValue!.isEmpty) {
                        return 'Please enter tenor';
                      }
                      tenor = tenorValue;
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _create();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _create() async{
    var data = {
      'plafon' : plafon,
      'tenor' : tenor
    };

    var res = await Network().create(data, '/pengajuan/create');
    if(res.statusCode == 200){
      Navigator.pop(context);
    }
  }
}
