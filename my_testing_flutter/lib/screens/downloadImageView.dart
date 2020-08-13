import 'main.dart';

void changeCarColour(String carModelID, String carColor, int selectedCar) {
  try {
    var y = key.currentWidget.key;
    print("yyyyyyyyyyyyyyyyyyy is $y");
    var x = key.currentState.downloadImage(
        "http://18.157.167.102:7066/Content/Images/CarMake/Image360/exterior/${carModelID}/${carColor}/",
        "Mod${carModelID}_Col${carColor}",
        selectedCar);
  } catch (e) {
    print("keyyyyyyy exception is $e");
  }
}
