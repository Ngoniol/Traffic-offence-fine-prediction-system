import 'package:flutter/material.dart';

class Lists extends StatefulWidget {
 final List<String> items; // list parameter
 final String text;
 final Function(String) onItemSelected;
 const Lists({super.key, required this.items, required this.text, required this.onItemSelected});

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  late List<String> _list;
  late String dropdownValue;
  late String texts;

  @override
  void initState() {
    super.initState();
    _list = widget.items;
    texts = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    dropdownValue=_list.first;
    return DropdownButton<String>(
      hint: Text(texts),
      icon: const Icon(Icons.arrow_drop_down_outlined),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        widget.onItemSelected(dropdownValue);
      },
      items: _list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
