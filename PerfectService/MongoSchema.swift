#if os(Linux)
	import SwiftGlibc
#else
	import Darwin
#endif

import MongoDB
import PerfectLib

protocol MongoSchema {
	var collection: MongoCollection { get }
	
	init?(collectionName: String)
	init?(collectionName: String, params: Any?...)
	func insert() throws -> Bool
	func insert(jsonObject: [String: Any]) throws -> Bool
	func close()
	func toJSON() -> [String: Any]
}

extension MongoSchema {
	
	init?(collectionName: String) {
		self.init(collectionName: collectionName, params: nil)
	}
	
	func insert(jsonObject: [String: Any]) throws -> Bool {
		do {
			let jsonString = try JSONEncoder().encode(jsonObject)
			let document = try BSON(json: jsonString)
			let result = collection.insert(document)
			switch result {
			case .Success:
				return true
			default:
				return false
			}
		} catch {
			print(error)
		}
		return false
	}
	
	func insert() throws -> Bool {
		return try insert(toJSON())
	}
	
	func close() {
		collection.close()
	}
}