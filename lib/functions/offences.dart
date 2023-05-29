class Offence {
  final String offenceType;
  final String section;
  final int fineAmount;

  Offence({
    required this.offenceType,
    required this.section,
    required this.fineAmount,
  });
}

List<Offence> offences = [
  Offence(
    offenceType: "Driving without identification plates",
    section: "Act Section 12(1) and 14 ",
    fineAmount: 10000,
  ),
  Offence(
    offenceType: "Over speeding by 1-5 kph",
    section: "Act Section 12(1) and 14 ",
    fineAmount: 500,
  ),
  Offence(
    offenceType: "Over speeding by 6-10 kph",
    section: "Act Section 12(1) and 14",
    fineAmount: 3000,
  ),
  Offence(
    offenceType: "Over speeding by 11-15 kph",
    section: "Act Section 12(1) and 14",
    fineAmount: 6000,
  ),
  Offence(
    offenceType: "Over speeding by 16-20 kph",
    section: "Act Section 12(1) and 14",
    fineAmount: 10000,
  )
];


