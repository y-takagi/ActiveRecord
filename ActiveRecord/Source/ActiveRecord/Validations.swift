public protocol Validations {
  func runValidateCallbacks()
  func validates_presence_of(_ attribute: String)
  func validates_uniqueness_of(_ attribute: String)
  func validates_format_of(_ attribute: String, format: String)
}

extension ActiveRecord: Validations {
  public func isValid() -> Bool {
    errors.removeAll()
    return runValidations() && validateRelations()
  }

  public func validates_presence_of(_ attribute: String) {
    switch self.value(forKey: attribute) {
    case let value as String:
      if value.isEmpty {
        errors[attribute] = "is empty."
      }
    case .none:
      errors[attribute] = "is nil."
    default:
      break
    }
  }

  public func validates_uniqueness_of(_ attribute: String) {}

  public func validates_format_of(_ attribute: String, format: String) {
    guard let value = self.value(forKey: attribute) as? String else { return }
    if !NSPredicate(format: "SELF MATCHES %@", format).evaluate(with: value) {
      errors[attribute] = "Doesn't match to format: \(format)"
    }
  }

  private func runValidations() -> Bool {
    runValidateCallbacks()
    return errors.isEmpty
  }

  private func validateRelations() -> Bool {
    return objectSchema.properties.filter { $0.objectClassName != nil
      }.map {
        if let rel = value(forKey: $0.name) as? Relationable {
          return rel.isValid()
        } else {
          return true
        }
      }.reduce(true, { $0 && $1 })
  }
}
