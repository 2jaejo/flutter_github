import '../login.dart';
import '../routeTest/sign_in.dart';
import '../routeTest/page_alert.dart';
import '../routeTest/page_http.dart';
import '../routeTest/page_image.dart';
import '../routeTest/page_picker.dart';
import '../routeTest/page_cupertino.dart';
import '../routeTest/page_regexp.dart';
import '../routeTest/page_local_auth.dart';
import '../routeTest/page_foreground.dart';

import '../routeTest/pageA.dart';
import '../routeTest/pageB.dart';
import '../routeTest/pageC.dart';
import '../routeTest/pageD.dart';

class NwPage {
  set(page, {title = '', message = ''}) {
    var result;
    switch (page) {
      case 'pageA':
        result = PageA(title: title, message: message);
        break;
      case 'pageB':
        result = PageB();
        break;
      case 'pageC':
        result = PageC(title: title, message: message);
        break;
      case 'pageD':
        result = PageD(title: title, message: message);
        break;
      case 'signin':
        result = Signin();
        break;
      case 'alert':
        result = PageAlert();
        break;
      case 'http':
        result = PageHttp();
        break;
      case 'image':
        result = PageImage();
        break;
      case 'picker':
        result = PagePicker();
        break;
      case 'cupertino':
        result = PageCupertino();
        break;
      case 'regexp':
        result = PageRegexp();
        break;
      case 'localauth':
        result = PageLocalAuth();
        break;
      case 'foreground':
        result = PageForeground();
        break;
      default:
        result = Login();
        break;
    }

    return result;
  }
}
