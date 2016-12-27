import ActiveRecord
import RealmSwift

Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TestDatabase"

class Person: ActiveRecord, ObjectBase {
  typealias ModelType = Person

  dynamic var name: String = ""
  dynamic var car: Car?
  let pets = List<Pet>()

  override func destroyDependencies() -> [Any?] {
    return [car, pets]
  }
}

class Car: ActiveRecord, ObjectBase {
  typealias ModelType = Car

  dynamic var name: String = ""
  let owners = LinkingObjects(fromType: Person.self, property: "car")
  var owner: Person {
    return owners.first!
  }
}

class Pet: ActiveRecord, ObjectBase {
  typealias ModelType = Pet

  dynamic var name: String = ""
  let owners = LinkingObjects(fromType: Person.self, property: "pets")
  var owner: Person {
    return owners.first!
  }
}

