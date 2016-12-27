import ActiveRecord
import XCTest

class ActiveRecordTests: XCTestCase {
  override func setUp() {
    super.setUp()
    setupDatabase()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testAttribute() {
    let owner = Person()

    XCTAssert(owner.id.isEmpty == false)
    XCTAssert(owner.createdAt.timeIntervalSinceNow < 1)
    XCTAssert(owner.updatedAt.timeIntervalSinceNow < 1)
  }
}
