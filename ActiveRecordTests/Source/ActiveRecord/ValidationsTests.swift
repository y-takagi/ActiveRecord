import ActiveRecord
import XCTest

class ValidationsTests: XCTestCase {
  override func setUp() {
    super.setUp()
    setupDatabase()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testValidatesPresenceOf() {
    let owner = PersonFactory.build()
    owner.name = ""
    owner.car = nil

    XCTAssert(owner.isValid() == false)
    XCTAssert(owner.errors.count == 2)
    XCTAssert(owner.errors["name"] == "is empty.")
    XCTAssert(owner.errors["car"] == "is nil.")

    owner.name = "Tarou"
    XCTAssert(owner.isValid() == false)
    XCTAssert(owner.errors.count == 1)

    owner.car = CarFactory.build()
    XCTAssert(owner.isValid() == true)
    XCTAssert(owner.errors.count == 0)
  }

  func testValidatesFormatOf() {
    let owner = PersonFactory.build()
    owner.tel = ""

    XCTAssert(owner.isValid() == false)
    XCTAssert(owner.errors.count == 1)
    XCTAssert(owner.errors["tel"] == "Doesn't match to format: [0-9]+-[0-9]+-[0-9]+")

    owner.tel = "08011223344"
    XCTAssert(owner.isValid() == false)
    XCTAssert(owner.errors.count == 1)
    XCTAssert(owner.errors["tel"] == "Doesn't match to format: [0-9]+-[0-9]+-[0-9]+")

    owner.tel = "080-1122-3344"
    XCTAssert(owner.isValid() == true)
    XCTAssert(owner.errors.count == 0)
  }
}
