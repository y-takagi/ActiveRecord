import ActiveRecord
import RealmSwift

final class Dog: ActiveRecord, ObjectBase {
  typealias ObjectType = Dog

  @objc dynamic var name: String = ""

  // inverse relations
  let owners = LinkingObjects(fromType: Person.self, property: "dogs")
  var owner: Person {
    return owners.first!
  }
}
