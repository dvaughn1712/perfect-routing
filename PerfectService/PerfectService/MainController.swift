
import PerfectLib
import MongoDB

public class MainController {
	
	func getHomePage(request: WebRequest, response: WebResponse) {
		response.appendBodyString("<html><body><h1>Welcome to our club!!</h1></body></html>")
	}
	
	func testRequest(request: WebRequest, response: WebResponse) {
		response.appendBodyString("RESPONSE FROM \(self.dynamicType) \(#function)")
	}
	
	func getUser(request: WebRequest, response: WebResponse) {
		response.appendBodyString("<html><body>Echo 2 handler: You GET accessed path \(request.requestURI()) with variables \(request.urlVariables)<br>")
		response.appendBodyString("<form method=\"POST\" action=\"/user/\(request.urlVariables["id"] ?? "error")/baz\"><button type=\"submit\">POST</button></form></body></html>")
	}
	
	func addUser(request: WebRequest, response: WebResponse) {
		response.appendBodyString("<html><body>Echo 3 handler: You POSTED to path \(request.requestURI()) with variables \(request.urlVariables)</body></html>")
		
		do {
			let userModel = UserModel(databaseName: "TestData")
			let jsonObject: [String: Any] = [
				"username": request.urlVariables["id"]!,
				"password": "whatever"
			]
			
			let result = try userModel.insert(jsonObject)
			print(result)
			userModel.close()
		} catch {
			print("there was an error: \(error)")
		}
		
		print(mongoClient!.getDatabase("TestData").collectionNames())
		print(mongoClient!.getDatabase("TestData").getCollection("Users").count(try! BSON(json: "{}")))
		let cursor = mongoClient!.getDatabase("TestData").getCollection("Users").find(try! BSON(json: "{}"))
		
		while let data = cursor?.next() {
			print("CURSOR DATA: \(data)")
		}

		response.requestCompletedCallback()
	}
}