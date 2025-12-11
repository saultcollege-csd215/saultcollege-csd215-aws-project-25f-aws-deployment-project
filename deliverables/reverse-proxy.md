Reverse Proxy Purpose and Benefits


Purpose

nginx serves as a reverse proxy that accepts HTTP requests on port 80 from external clients and forwards them to the Flask application running on port 8000 internally. It acts as an intermediary layer between the internet and the Flask app.

Benefits

1. Security
Isolation: Flask app runs on localhost (127.0.0.1) and is not directly exposed to the internet

Attack Protection: nginx can filter malicious requests before they reach the application

Hide Infrastructure: External users only see nginx, not the underlying Flask/Gunicorn setup

2. Performance
Static File Serving: nginx efficiently serves static files (CSS, JS, images) without involving Flask

Caching: Can cache responses to reduce server load

Connection Handling: Manages multiple client connections efficiently

3. Production Readiness
Standard Ports: Allows Flask to run on port 8000 while being accessible on standard HTTP port 80

Process Separation: Web server (nginx) and application server (Gunicorn) run independently

Auto-Restart: Both services are managed by systemd for automatic recovery

4. Scalability
Load Distribution: Can distribute requests across multiple Flask worker processes

Future Expansion: Easy to add SSL, load balancing, or CDN integration