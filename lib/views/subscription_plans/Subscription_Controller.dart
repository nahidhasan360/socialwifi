import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PlanController extends GetxController {
  var selectedPlan = ''.obs;

  void selectIndividual() => selectedPlan.value = 'individual';
  void selectTeam() => selectedPlan.value = 'team';

  void restoreSubscription() {
    // Implement restore logic here
  }
}
