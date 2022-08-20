import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'HELLO WORLD',
          'message': "WELCOME TO PROTO CODERS POINT"
        },
        'hi_IN': {
          'hello': 'नमस्ते दुनिया',
          'message': "प्रोटो कोडर्स पॉइंट में आपका स्वागत है"
        }
      };
}
