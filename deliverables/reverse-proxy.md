What is a reverse proxy?
A reverse proxy is a server that stands in between the front of the webservers and forwards client (ie web browser) requests to web servers. Reverse proxies are usually implemented to increase security, performance and reliability.

The purpose of nginx as a reverse proxy in this lab deployment was to act as a reverse proxy between the internet and the flask application. This is the best practice for deploying Flask applications when in production. This provides a secure, robust and performant layer between the users, application and handling concerns that Flask was never intended to address. This separation of concerns allows for Flask to focus on application logic while the nginx handles the complexities

Conclusion
Using nginx as a reverse proxy is a best practice for deploying Flask applications in production. It provides a robust, secure, and performant layer between users and the application, handling concerns that Flask was never designed to address. This separation of concerns allows Flask to focus on application logic while nginx handles the complexities of serving web traffic at scale.
