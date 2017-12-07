import ActiveRecord
import RealmSwift

final class Car: ActiveRecord, ObjectBase {
  typealias ObjectType = Car

  // inverse relations
  let owners = LinkingObjects(fromType: Person.self, property: "car")
  var owner: Person {
    return owners.first!
  }
}
