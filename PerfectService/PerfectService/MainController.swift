
import PerfectLib

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
		response.requestCompletedCallback()
	}
}