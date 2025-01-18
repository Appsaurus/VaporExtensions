//
//  ResponseExtensions.swift
//  VaporTestUtils
//
//

import Foundation
import XCTVapor


extension XCTHTTPResponse {

	/// Get header by it's name
	public func header(name: String) -> String? {
		let headerName = HTTPHeaders.Name(name)
		return header(name: headerName)
	}

	/// Get header by it's HTTPHeaders.Name representation
    public func header(name: HTTPHeaders.Name) -> String? {
		return headers[name].first
	}

    /// Size of the content
    public var contentSize: Int? {
        return body.readableBytes
    }

    /// Get content string. Maximum of 0.5Mb of text will be returned
    public var contentString: String? {
        return contentString(encoding: .utf8)
    }

    /// Get content string with encoding. Maximum of 0.5Mb of text will be returned
    public func contentString(encoding: String.Encoding) -> String? {
        var b = body
        guard let data = b.readData(length: b.readableBytes) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
}


extension XCTHTTPResponse {

	/// Test header value
	public func has(header name: HTTPHeaders.Name, value: String? = nil) -> Bool {
		guard let header = header(name: name) else {
			return false
		}

		if let value = value {
			return header.contains(value)
		}
		else {
			return true
		}
	}

	/// Test header value
	public func has(header name: String, value: String? = nil) -> Bool {
		let headerName = HTTPHeaders.Name(name)
		return has(header: headerName, value: value)
	}

	/// Test header Content-Type
	public func has(contentType value: String) -> Bool {
		let headerName = HTTPHeaders.Name("Content-Type")
		return has(header: headerName, value: value)
	}

	/// Test header Content-Length
	public func has(contentLength value: Int) -> Bool {
		let headerName = HTTPHeaders.Name("Content-Length")
		return has(header: headerName, value: String(value))
	}

	/// Test response status code
	public func has(statusCode value: HTTPStatus) -> Bool {
		return status.code == value.code
	}

	/// Test response status code and message
	public func has(statusCode value: HTTPStatus, message: String) -> Bool {
		return status.code == value.code && status.reasonPhrase == message
	}

	/// Test response content
	public func has(content value: String) -> Bool {
		return contentString == value
	}
}
