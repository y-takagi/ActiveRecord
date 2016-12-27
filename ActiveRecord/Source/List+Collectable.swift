import RealmSwift

protocol Collectable {
  var all: [Object] { get }
}

extension List: Collectable {
  public var all: [Object] {
    return self.flatMap { $0 }
  }
}
