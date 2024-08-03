import Foundation

public extension Comparable {
    func `is`(_ comparison: @escaping (Self, Self) -> Bool, _ value: Self) -> Bool {
        return comparison(self, value)
    }

    func `is`(_ comparison: @escaping (Self, Self) -> Bool, _ value: Self, or error: Error) throws -> Self {
        try self.is(comparison, value)
            .is(true, or: error)
        return self
        
    }
}

extension Bool {
    func `is`(_ value: Bool, or error: Error) throws {
        guard self == value else {
            throw error
        }
    }
}
