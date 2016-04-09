import PerfectLib
import MongoDB


var mongoClient: MongoClient?

public func PerfectServerModuleInit() {

	do {
		mongoClient = try MongoClient(uri: "mongodb://localhost/test_database")
	} catch {
		print("Mongo error: \(error)")
	}
	
	Router.CreateRoutes()
}