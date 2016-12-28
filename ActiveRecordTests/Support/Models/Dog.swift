import ActiveRecord
import RealmSwift

class Dog: ActiveRecord, ObjectBase {
  typealias ModelType = Dog

  dynamic var name: String = ""

  // inverse relations
  let owners = LinkingObjects(fromType: Person.self, property: "dogs")
  var owner: Person {
    return owners.first!
  }
}
