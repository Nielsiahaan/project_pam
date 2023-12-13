import 'package:frontendapp/models/requestIB_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RequestIBController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<RequestIbModel> requestIB = RxList<RequestIbModel>();

  // Future 
}