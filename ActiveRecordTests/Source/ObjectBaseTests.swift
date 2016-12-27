import ActiveRecord
import RealmSwift
import XCTest

class ObjectBaseTests: XCTestCase {
  override func setUp() {
    super.setUp()
    setupDatabase()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testObjects() {
    XCTAssert(type(of: Person.objects) == Results<Person>.self)
    XCTAssert(type(of: Dog.objects) == Results<Dog>.self)
  }

  func testFind() {
    let owner = Person()
    owner.name = "Tarou"
    try! owner.save()

    XCTAssert(Person.find(owner.id)?.name == "Tarou")
  }
}
