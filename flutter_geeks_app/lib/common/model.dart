
abstract class GEModel {
  GEModel getModel(String responseJSON);

  GEModel getModelFromMap(Map<String, dynamic> responseJSON) {
    throw UnimplementedError();//TODO: look into later
  }
}