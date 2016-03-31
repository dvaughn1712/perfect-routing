# perfect-routing
PerfectServer for Swift 2.2 Open Source. A more readable way of doing their URL Routing example.

If you too are just as confused as I was when setting up a PerfectServer instance then this is the project for you! This implementation closely resembles how a Node.js routing system is done by making converting the URL Routing example into something a bit more readable. I was not happy with how a class had to be created for each route and so I found a way to use a struct to handle how the messages are sent. 
This example enhances how the URL Routing works. Instead of assigning a Closure statement that expects a ( (_:WebResponse) -> RequestHandler) you can now pass in a function and use the more straitforward meaning of Request.handle( (request: WebRequest, response: WebResponse) -> () ).

Simply define a function as such: func getUser(request: WebRequest, response: WebResponse) and pass the function into Request.handle().
