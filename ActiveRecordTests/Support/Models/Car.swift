import ActiveRecord
import RealmSwift

class Car: ActiveRecord, ObjectBase {
  typealias ModelType = Car

  // inverse relations
  let owners = LinkingObjects(fromType: Person.self, property: "car")
  var owner: Person {
    return owners.first!
  }
}
