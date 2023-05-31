import 'package:project/charts/individual_bar.dart';

class BarData{
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount});

  List<IndividualBar> barData =[];

  void initializedBarData(){
    barData = [
      //sum
      IndividualBar(x: 0, y: sunAmount),
      //sum
      IndividualBar(x: 1, y: monAmount),
      //sum
      IndividualBar(x: 2, y: tueAmount),
      //sum
      IndividualBar(x: 3, y: wedAmount),
      //sum
      IndividualBar(x: 4, y: thurAmount),
      //sum
      IndividualBar(x: 5, y: friAmount),
      //sum
      IndividualBar(x: 6, y: satAmount)
    ];
  }
}