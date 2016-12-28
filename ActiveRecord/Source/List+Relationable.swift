import RealmSwift

extension List: Relationable {
  public func cascadingDestroy() throws {
    try forEach {
      if let rel = $0 as? ActiveRecord {
        try rel.cascadingDestroy()
      }
    }
  }

  public func isValid() -> Bool {
    return map {
             if let rel = $0 as? ActiveRecord {
               return rel.isValid()
             } else {
               return true
             }
           }.reduce(true, { $0 && $1 })
  }
}
