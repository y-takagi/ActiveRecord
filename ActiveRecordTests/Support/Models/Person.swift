import ActiveRecord
import RealmSwift

class Person: ActiveRecord, ObjectBase {
  typealias ModelType = Person

  dynamic var name: String = ""
  dynamic var age: Int = 0

  // to-many relations
  let dogs = List<Dog>()

  override func destroyDependencies() -> [Relationable?] {
    return [dogs]
  }
}
