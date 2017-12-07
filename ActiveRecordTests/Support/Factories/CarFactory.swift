struct CarFactory: Factory {
  typealias ModelType = Car

  static func build(value: [String: Any] = [:]) -> Car {
    return Car()
  }
}
