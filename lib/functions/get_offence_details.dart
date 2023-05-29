import 'package:flutter/material.dart';
import 'offences.dart';

class getOffenceDetails extends StatefulWidget {
  final String selectedOffence;
  const getOffenceDetails({Key? key, required this.selectedOffence}) : super(key: key);

  @override
  State<getOffenceDetails> createState() => _getOffenceDetailsState();
}

class _getOffenceDetailsState extends State<getOffenceDetails> {
  late String selectedOffences;

  @override
  void initState() {
    super.initState();
    selectedOffences = widget.selectedOffence;
  }
  @override
  void didUpdateWidget(getOffenceDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOffence != selectedOffences) {
      setState(() {
        selectedOffences = widget.selectedOffence;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Offence ? offence = offences.firstWhere((offence) => offence.offenceType == selectedOffences);
    return Text('${offence.offenceType} \nContrary to Traffic ${offence.section} \nFineable by ${offence.fineAmount} Kenyan shillings');
  }
}
