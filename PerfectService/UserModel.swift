import MongoDB

struct UserModel: MongoSchema {
	
	let collection: MongoCollection
	let userName: String
	let firstName: String
	let lastName: String
	
	init?(collectionName: String, params: Any?...) {
		collection = MongoCollection(client: mongoClient!, databaseName: mongoDatabase.name(), collectionName: "Users")
		guard let userName = params[0] as? String,
			let firstName = params[1] as? String,
			let lastName = params[2] as? String else {
				return nil
		}
		self.userName = userName
		self.firstName = firstName
		self.lastName = lastName
	}
	
	func toJSON() -> [String : Any] {
		let json: [String: Any] = [
			"userName": userName,
			"firstName": firstName,
			"lastName": lastName
		]
		return json
	}
}