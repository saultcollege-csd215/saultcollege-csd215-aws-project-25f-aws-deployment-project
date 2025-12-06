In this lab, nginx acts as a reverse proxy in front of the Flask application running on the EC2 instance. Instead of exposing the Flask app directly to the internet, nginx receives all incoming HTTP requests on port 80 and forwards them to the Flask app running on its internal port.

Purpose and Benefits
1. Security and Isolation

The Flask app does not need to listen on a public-facing port.

nginx handles all external traffic, reducing the attack surface.

It allows you to hide internal application architecture.

2. Stable, Production-Ready Request Handling

Flask’s built-in server is not designed for production workloads.

nginx handles high traffic efficiently, managing connections, buffering, and timeouts.

3. Reverse Proxy Routing

nginx takes requests from the browser and forwards them to the Flask app.

Lets the application run on any internal port without exposing it directly.