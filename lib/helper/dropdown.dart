import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownMenuExample extends StatefulWidget {
   String text;
   List<String> list;
   Function(String?) onSelected;
   Color color;

  DropdownMenuExample({
    required this.text,
    required this.list,
    required this.onSelected,
    required this.color,
  });

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownMenu<String>(
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: widget.color,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.color),
          ),
          hintStyle: TextStyle(color: widget.color),
        ),
        textStyle: TextStyle(
          color: widget.color,
        ),
        width: 345,
        menuHeight: 300,
        hintText: widget.text,
        // initialSelection: widget.list.first,
        onSelected: (String? value) {
          // Call the onSelected callback with the selected value
          widget.onSelected(value);
          // Update the local state if needed
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}

