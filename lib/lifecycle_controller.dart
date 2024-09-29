import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {
    // print('App is detached');
  }

  @override
  void onInactive() {
    // print('App is inactive');
  }

  @override
  void onPaused() {
    // print('App is paused');
  }

  @override
  void onHidden() {
    // print('App is hidden');
  }

  @override
  void onResumed() {
    // print('App is resumed');
  }
}
