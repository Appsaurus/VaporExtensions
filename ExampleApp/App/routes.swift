import Vapor

/// Register your application's routes here.
public func routes(_ app: Application) throws {
    app.get("testing-vapor-apps") { req in
        return "is super easy".encodeResponse(for: req)
    }
}
