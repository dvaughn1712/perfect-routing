import MongoDB
import PerfectLib

struct UserModel: MongoSchema {
	
	let collection: MongoCollection
	
	init(databaseName: String) {
		collection = MongoCollection(client: mongoClient!, databaseName: databaseName, collectionName: "Users")
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

	func close() {
		collection.close()
	}
}