import ActiveRecord
import RealmSwift

final class Person: ActiveRecord, ObjectBase {
  typealias ObjectType = Person

  @objc dynamic var name: String = ""
  @objc dynamic var age: Int = 0
  @objc dynamic var tel: String = ""

  // to-one relations
  @objc dynamic var car: Car?

  // to-many relations
  let dogs = List<Dog>()

  override func destroyDependencies() -> [Relationable?] {
    return [car, dogs]
  }

  override func runValidateCallbacks() {
    validates_presence_of("name")
    validates_presence_of("car")
    validates_format_of("tel", format: "[0-9]+-[0-9]+-[0-9]+")
  }
}
