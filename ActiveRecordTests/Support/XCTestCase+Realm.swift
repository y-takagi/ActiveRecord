import ActiveRecord
import RealmSwift
import XCTest

extension XCTestCase {
  func setupDatabase() {
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "TestDatabase"
    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
    ActiveRecord.realm = realm
  }
}
