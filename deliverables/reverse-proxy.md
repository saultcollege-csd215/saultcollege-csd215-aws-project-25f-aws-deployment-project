In this deployment architecture, nginx is used as a reverse proxy in front of the Flask application running on the EC2 instance.

Why use nginx?
Public-facing web server
nginx listens on port 80, which is the standard HTTP port.
Flask's built-in development server is not designed to be exposed directly to the internet.

Security
nginx provides a hardened, production-ready surface.
It prevents direct access to the Flask server.

Performance
nginx is optimized for high concurrency and static file serving.
It offloads traffic handling from the Flask app.

Process management
The Flask app runs as a background systemd service.
nginx stays up even if Flask restarts.

Routing
nginx forwards all HTTP requests to Flask on localhost:5000.
Overall benefit

Using nginx creates a cleaner, safer, and more scalable deployment, while allowing the Flask app to run efficiently in the background without exposing its internal port.