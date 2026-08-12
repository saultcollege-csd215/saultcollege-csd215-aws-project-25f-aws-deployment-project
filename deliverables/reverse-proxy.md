# Nginx Reverse Proxy

Nginx is used as a reverse proxy between users and the Flask application. Incoming HTTP requests are sent to nginx on port 80, and nginx forwards those requests to the Flask application running internally on the EC2 instance.

Using nginx allows the Flask application to run on an internal port without exposing that port directly to the internet. It also provides a dedicated web server for handling incoming connections and can improve reliability and performance.

This setup also makes it easier to add features such as HTTPS, logging, caching, load balancing, and request filtering without changing the Flask application itself.