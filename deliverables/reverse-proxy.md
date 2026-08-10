# Nginx as a Reverse Proxy

In this setup, nginx sits in front of the Flask application. It listens for HTTP requests on port 80 and forwards them to Gunicorn, which is running locally on port 8000.

## Why use nginx?

- Keeps Gunicorn private: Gunicorn listens on `127.0.0.1:8000`, so it is not directly exposed to the internet. Users access the application through nginx on port 80.
- Handles incoming HTTP traffic: Nginx receives requests from clients and passes them to the Flask application through Gunicorn.
- Better handling of connections: Nginx is designed to handle many incoming connections efficiently and can handle things like buffering and slow clients before passing requests to the application.
- Adds flexibility: Nginx can also be used for features such as SSL/TLS termination, serving static files, rate limiting, and load balancing if the application needs them in the future.
- Works well with systemd: In this setup, both nginx and the Flask/Gunicorn application are managed as systemd services, so they can start automatically and be restarted if needed.