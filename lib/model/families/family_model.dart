class FamilyModel {
//moduł opony
  int _id;
  String _name; 
  int _hivesNumber; 
  String _honey; 
  String _location; 
  int _litersNumber; 

  // Constructor
  FamilyModel(this._name, this._hivesNumber, this._honey,
      this._location, this._litersNumber);
  FamilyModel.withId(this._id, this._name, this._hivesNumber, this._honey,
      this._location, this._litersNumber);

  // getters
  int get id => _id;
  String get name => _name;
  int get hivesNumber => _hivesNumber;
  String get honey => _honey;
  String get location => _location;
  int get litersNumber => _litersNumber;

  // setters
  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set hivesNumber(int newHivesNumber) {
        _hivesNumber = newHivesNumber;
    }

  set honey(String newHoney) {
    if (newHoney.length <= 255) {
      _honey = newHoney;
    }
  }

  set location(String newLocation) {
    if (newLocation.length <= 255) {
      _location = newLocation;
    }
  }

  set litersNumber(int newLitersNumber) {
        _litersNumber = newLitersNumber;
    }

  Map<String, dynamic> toMap() {
    var familiesMap = Map<String, dynamic>();
   familiesMap['name'] = _name;
   familiesMap['hivesNumber'] = _hivesNumber;
   familiesMap['honey'] = _honey;
   familiesMap['location'] = _location;
    familiesMap['litersNumber'] = _litersNumber;
    if (_id != null) {
     familiesMap['id'] = _id;
    }
    return familiesMap;
  }
}
