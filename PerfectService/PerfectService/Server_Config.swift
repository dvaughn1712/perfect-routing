import PerfectLib
import MongoDB


var mongoClient: MongoClient!
var mongoDatabase: MongoDatabase!

public func PerfectServerModuleInit() {

	do {
		mongoClient = try MongoClient(uri: "mongodb://localhost/TestData")
		mongoDatabase = mongoClient.getDatabase("TestData")
		Router.CreateRoutes()
	} catch {
		print("Mongo error: \(error)")
	}
}