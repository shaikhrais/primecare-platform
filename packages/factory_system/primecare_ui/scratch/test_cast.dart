
class Blueprint {}
class Model {
  final List<Blueprint> blueprints;
  Model(this.blueprints);
}

void main() {
  dynamic m = Model([Blueprint()]);
  try {
    print('Attempting direct access...');
    var bps = m.blueprints;
    print('Type of blueprints: ${bps.runtimeType}');
    
    print('Attempting cast to List<dynamic>...');
    var casted = bps as List<dynamic>;
    print('Cast successful: ${casted.runtimeType}');
  } catch (e) {
    print('Cast failed: $e');
  }
  
  try {
    print('Attempting cast to Iterable...');
    var iter = m.blueprints as Iterable;
    print('Iterable cast successful');
    var list = iter.cast<Blueprint>().toList();
    print('Final list type: ${list.runtimeType}');
  } catch (e) {
    print('Iterable cast failed: $e');
  }
}
