import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _age;
  var box = Hive.box('contacts');
  void addContact(Contact contact) {
    box.add(contact); // add give autoincremental keys
    // box.put(key, value) ------ put needs both key and  value
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value!,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _age = value!,
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Add New Contact'),
            onPressed: () {
              _formKey.currentState?.save();
              final newContact = Contact(_name, int.parse(_age));
              addContact(newContact);
            },
          ),
        ],
      ),
    );
  }
}
