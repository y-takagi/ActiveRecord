public protocol Relationable {
  func cascadingDestroy() throws
  func isValid() -> Bool
}
