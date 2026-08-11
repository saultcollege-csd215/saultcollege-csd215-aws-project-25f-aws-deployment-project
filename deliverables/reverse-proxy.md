In this project, nginx is used as a reverse proxy for the Flask application running within the EC2 instance. Flask is not ideal for receiving traffic directly from the internet, so nginx acts as an intermediary layer that improves security, performance, and organization of the application.

Why nginx is necessary

Flask runs internally on port 8000, while users access the application via port 80 (HTTP). Nginx receives these external requests and forwards them to Flask. This avoids directly exposing the application server and creates a more professional and secure structure.

Benefits of using nginx as a reverse proxy

1. Security NGinx sits in front of the application, receiving all public traffic.

The Flask application is protected, running only internally.

This reduces exposure and prevents users from directly accessing the application's service.

2. Performance NGinx is optimized to handle many simultaneous connections.

It manages buffers, queues, and connections much more efficiently than Flask's internal server.

This makes the application faster and more stable.

3. Stability Even if Flask restarts or takes a long time to respond, nginx remains active.

It can also automatically restart the service and better handle traffic spikes.

4. Architectural organization NGinx handles the "web" part (port 80), while Flask handles the application logic.

This separation is the recommended standard for Python applications in production.

5. Request Forwarding

The configuration used in the project:

proxy_pass http://127.0.0.1:8000;


This means that:

The user accesses EC2 through port 80
Nginx receives the request
Nginx forwards it to Flask on port 8000
The user never sees the application's internal port.

Using nginx as a reverse proxy brings:

more security
better performance
greater stability
more organized architecture
support for advanced features in the future (HTTPS, caching, compression)