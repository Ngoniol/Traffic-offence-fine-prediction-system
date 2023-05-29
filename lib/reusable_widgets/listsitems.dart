import 'package:project/functions/offences.dart';

List<String> offenceTypes = offences.map((offence) => offence.offenceType).toList();

List<String> vehicleType = [
  'Personal car',
  'PSV',
  'Motorcycle',
];

List<String> decisions = [
  'Notice to attend Court',
  'Fine on the spot',
];

List<String> paymentMethods = [
  'Cash',
  'Mpesa',
  'Mobile banking'
];

List<String> choice = [
  'Yes',
  'No',
];
List<String> roads = [
  'Waiyaki way',
  'Mombasa road',
  'Carnivore road',
  'Kikuyu road',
  'Langata road',
  'Naivasha road',
  'Ndonyo road',
  'Kungu Karumba',
  'Kabiria road',
  'Kapenguria road',
  'Thiongo road',
  'Magadi road',
  'Gitanga road',
  'Muhuri road',
  'James Gichuru road',
  'Muthua road',
  'Uhuru highway',
  'Thika road',
  'Ngong road',
  'Jogoo road',
  'Juja road',
  'Limuru road',
  'Kiambu road',
  'Eastern Bypass',
  'Southern Bypass',
  'Northern Bypass',
  'Outer Ring road',
  'Forest road',
  'Argwings Kodhek road',
];

List<String> courts = [
  'Milimani law courts',
  'Kibera courts',
  'Makadara courts'
];