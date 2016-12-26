
public protocol Validations {
  func isValid() -> Bool
  func runValidateCallbacks()
  func validates_presence_of(_ attribute: String)
  func validates_uniqueness_of(_ attribute: String)
  func validates_numericality_of(_ attribute: String)
  func validates_format_of(_ attribute: String, format: String)
}

extension Validations where Self: ActiveRecord {
  public func isValid() -> Bool {
    errors.removeAll()
    return runValidations()
  }

  public func validates_presence_of(_ attribute: String) {
    if let value = self.value(forKey: attribute) {
      switch value {
      case let value as String:
        if value.isEmpty {
          errors[attribute] = "is empty."
        }
      default:
        break
      }
    } else {
      errors[attribute] = "is nil."
    }
  }

  public func validates_uniqueness_of(_ attribute: String) {}
  public func validates_numericality_of(_ attribute: String) {}
  public func validates_format_of(_ attribute: String, format: String) {}

  private func runValidations() -> Bool {
    runValidateCallbacks()
    return errors.isEmpty
  }
}
