import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  final Function(DateTime?) onDateTimeSelected;
  const SelectDate({Key? key, required this.onDateTimeSelected}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  @override
  DateTime? selectedDateTime;

  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(dateTime);
  }
  Future<void> selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
      selectableDayPredicate: (DateTime date) {
        // Exclude weekends (Saturday and Sunday)
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }
        return true;
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedDateTime != null
            ? TimeOfDay.fromDateTime(selectedDateTime!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        //passing the selected date to the callback function
        widget.onDateTimeSelected(selectedDateTime);
      }
    }
  }
  Widget build(BuildContext context) {
    return Row(children: [
      ElevatedButton.icon(onPressed: () => selectDateTime(),
        icon: const Icon(Icons.calendar_month),
        label: const Text('Court date'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return const Color(0xFF5d7fbe);
          }),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      if (selectedDateTime != null)
        Text('Court date: ${_formatDateTime(selectedDateTime!)}')
    ]);
  }
}