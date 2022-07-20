import 'package:flutter/material.dart';
import 'package:kopelindo/core/utils/utils.dart';

class EditPage extends StatefulWidget {
  int id;
  int plafon;
  int tenor;
  EditPage({required this.id, required this.plafon, required this.tenor, Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
            const Text('Edit Pengajuan'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: widget.plafon.toString(),
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
                    initialValue: widget.tenor.toString(),
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
                        _edit();
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

  void _edit() async{
    var data = {
      'plafon' : plafon,
      'tenor' : tenor
    };

    var res = await Network().update(data, '/pengajuan/update/${widget.id}');
    if(res.statusCode == 200){
      Navigator.pop(context);
    }
  }
}
