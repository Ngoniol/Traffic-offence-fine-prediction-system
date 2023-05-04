import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../screens/register_offence.dart';

Future<void> sendEmail(String recipientEmail) async {

  final smtpServer = gmail('olgangoni@students.uonbi.ac.ke', '');

  final message = Message()
    ..from = const Address('olgangoni@students.uonbi.ac.ke', 'Traffic Department of Kenya')
    ..recipients.add(recipientEmail)
    ..subject = 'Traffic Offence Ticket'
    ..html = 'You are charged with the offence of  which is contrary to the Kenya Traffic act number  on  at ';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. Error: $e');
  }
}
