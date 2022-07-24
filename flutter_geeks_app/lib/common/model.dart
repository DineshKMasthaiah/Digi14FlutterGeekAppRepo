
abstract class GEModel {
  GEModel getModel(String responseJSON);

///Dio http framework returns Map responses for some requests.so, this method handles parsing map responses
  GEModel getModelFromMap(Map<String, dynamic> responseJSON);
}