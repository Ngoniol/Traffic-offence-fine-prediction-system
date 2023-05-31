import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:project/reusable_widgets/keys.dart';

Future<void> mpesaPayment(String number) async {
  dynamic transactionInitialisation;
  try{
    transactionInitialisation =
        await MpesaFlutterPlugin.initializeMpesaSTKPush(
            businessShortCode: businessShortCode,
            transactionType: TransactionType.CustomerBuyGoodsOnline,
            amount: 1.0,
            partyA: number,
            partyB: businessShortCode,
            callBackURL: Uri.parse("https://mydomain.com/path"),
            accountReference: 'KenyaTraffic',
            phoneNumber: number,
            baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
            transactionDesc: "TrafficFine",
            passKey: passkey
        );
    print(transactionInitialisation);
    return transactionInitialisation;
}
  catch (e) {
    print("Caught exception:" + e.toString());
  }

}