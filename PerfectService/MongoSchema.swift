#if os(Linux)
	import SwiftGlibc
#else
	import Darwin
#endif


import MongoDB
import PerfectLib

protocol MongoSchema {
	var collection: MongoCollection { get }
	init(databaseName: String)
	func insert(jsonObject: [String: Any]) throws -> Bool
	func close()
}