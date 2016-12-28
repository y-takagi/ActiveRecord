import ActiveRecord
import XCTest

class BaseTests: XCTestCase {
  override func setUp() {
    super.setUp()
    setupDatabase()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testSave() {
    // Create
    var owner = Person()
    try! owner.save()
    XCTAssert(Person.objects.count == 1)

    // Update
    owner = Person(value: owner)
    owner.name = "Tarou"
    try! owner.save()
    XCTAssert(Person.objects.count == 1)
    XCTAssert(Person.objects.first?.name == "Tarou")
  }

  func testDestroy() {
    let owner = Person()
    try! owner.save()
    XCTAssert(Person.objects.count == 1)

    try! owner.destroy()
    XCTAssert(Person.objects.count == 0)
  }

  func testCascadingDestroy() {
    let owner = Person()
    let dog = Dog()
    owner.dogs.append(dog)
    try! owner.save()
    XCTAssert(Person.objects.count == 1)
    XCTAssert(Dog.objects.count == 1)

    try! owner.destroy()
    XCTAssert(Person.objects.count == 0)
    XCTAssert(Dog.objects.count == 0)
  }
}
