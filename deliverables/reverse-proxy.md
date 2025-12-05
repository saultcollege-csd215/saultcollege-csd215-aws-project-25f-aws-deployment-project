# Purpose of Using nginx as a Reverse Proxy

- In this setup, nginx will act as a reverse proxy in front of the running Flask application on the EC2 instance. A reverse proxy sits between the client - typically a web browser - and the application server, forwarding incoming HTTP requests to the app and returning responses back to the client.

- Flask's development server is not designed to handle production traffic, so nginx provides a stable, secure, and efficient layer that manages incoming connections.

# Benefits of Using nginx as a Reverse Proxy

1. Better Performance and Load Handling

nginx is optimized to handle many concurrent connections. It serves web traffic much faster and more efficiently compared to Flask's built-in server.
That way, it's only necessary for the Flask app to perform application logic as the incoming requests are handled by nginx.

2. Security and Protection of the Application Server
nginx helps protect the Flask app from direct access by the public internet.
It can:
- Filter and Block Undesirable Traffic
- Force HTTPS If configured later
- Limit exposure of internal ports: Flask runs on port 5000; this is not publicly accessible
This reduces security risks.

3. Stable, Reliable Service Management
nginx continues running regardless of whether the Flask app restarts or errors.
It provides:
- Request buffering
- Graceful failure handling
- A consistent endpoint on port 80
This ensures much better uptimes and reliability of the application.

4. Port Mapping and URL Routing
The Flask application runs on port 5000 internally, while nginx is listening on port 80, which is the default HTTP port. Without nginx, users would access it at the EC2 instance using port 5000. 

5. Scaling Made Easier in the Future If several application servers or containers were added, nginx could: Balance traffic loads Route requests to various back-end services It allows for a flexible architecture for much more advanced deployments.