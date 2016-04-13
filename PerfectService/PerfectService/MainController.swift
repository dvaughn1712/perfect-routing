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
		response.appendBodyString("<form method=\"POST\" action=\"/user/\(request.urlVariables["id"] ?? "error")/baz\"><button type=\"submit\">POST</button><input name=\"firstName\" value=\"\(request.urlVariables["firstname"] ?? "")\"><input name=\"lastName\" value=\"\(request.urlVariables["lastname"] ?? "")\"></form></body></html>")
	}
	
	func addUser(request: WebRequest, response: WebResponse) {
		response.appendBodyString("<html><body>Echo 3 handler: You POSTED to path \(request.requestURI()) with url variables \(request.urlVariables) and post data: \(request.postParams)</body></html>")
		
		do {
			var postData = [String: Any]()
			request.postParams.forEach({ (key, value) in
				postData[key] = value
			})
			let userModel = UserModel(collectionName: "Users", params:
				request.urlVariables["id"],
				postData["firstName"],
				postData["lastName"]
				)
			print("model JSON: \(userModel?.toJSON())")
			print(try userModel?.insert())
			userModel?.close()
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