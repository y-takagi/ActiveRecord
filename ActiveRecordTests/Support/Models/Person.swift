import ActiveRecord
import RealmSwift

class Person: ActiveRecord, ObjectBase {
  typealias ModelType = Person

  dynamic var name: String = ""
  dynamic var age: Int = 0
  dynamic var tel: String = ""

  // to-one relations
  dynamic var car: Car?

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
