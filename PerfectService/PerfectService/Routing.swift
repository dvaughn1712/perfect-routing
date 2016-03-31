import PerfectLib

public func PerfectServerModuleInit() {
	
	let mainController = MainController()
	
	// Install the built-in routing handler.
	// Using this system is optional and you could install your own system if desired.
	Routing.Handler.registerGlobally()
	
	
	Routing.Routes["GET", ["/", "index.html"] ] = Request.handle(mainController.getHomePage)
	
	Routing.Routes["GET", "/test"] = Request.handle(mainController.testRequest)
	
	Routing.Routes["GET", "/user/{id}"] = Request.handle(mainController.getUser)
	
	Routing.Routes["POST", "/user/{id}/baz"] = Request.handle(mainController.addUser)
	// Check the console to see the logical structure of what was installed.
	print("\(Routing.Routes.description)")
}


struct HandlerWrapper: RequestHandler {
	
	var handlerFunction: ((request: WebRequest, resonse: WebResponse) -> Void)
	
	init(function: (WebRequest, WebResponse) -> Void) {
		self.handlerFunction = function
	}
	
	func handleRequest(request: WebRequest, response: WebResponse) {
		handlerFunction(request: request, resonse: response)
		response.requestCompletedCallback()
	}
}

struct Request {
	static func handle(function: (WebRequest, WebResponse) -> Void) -> RequestHandlerGenerator {
		return { (_:WebResponse) in HandlerWrapper(function: function) }
	}
}



