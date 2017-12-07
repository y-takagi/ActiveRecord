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
    var owner = PersonFactory.build()
    try! owner.save()
    XCTAssert(Person.objects.count == 1)

    // Update
    owner = Person(value: owner)
    owner.name = "Masaru"
    try! owner.save()
    XCTAssert(Person.objects.count == 1)
    XCTAssert(Person.objects.first?.name == "Masaru")
  }

  func testDestroy() {
    let owner = try! PersonFactory.create()
    XCTAssert(Person.objects.count == 1)

    try! owner.destroy()
    XCTAssert(Person.objects.count == 0)
  }

  func testCascadingDestroy() {
    let owner = try! PersonFactory.createAll()

    XCTAssert(Person.objects.count == 1)
    XCTAssert(Dog.objects.count == 1)

    try! owner.destroy()
    XCTAssert(Person.objects.count == 0)
    XCTAssert(Dog.objects.count == 0)
  }
}
