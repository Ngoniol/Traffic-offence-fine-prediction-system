import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../screens/register_offence.dart';

Future<void> sendEmail(String recipientEmail, String body) async {

  final smtpServer = gmail('olgangoni@students.uonbi.ac.ke', '');

  final message = Message()
    ..from = const Address('olgangoni@students.uonbi.ac.ke', 'Traffic Department of Kenya')
    ..recipients.add(recipientEmail)
    ..subject = 'Traffic Offence Ticket'
    ..html = body;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. Error: $e');
  }
}
