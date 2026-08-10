\# Nginx as a Reverse Proxy



In this setup, nginx sits in front of the Flask application. It listens for

HTTP requests on port 80 and forwards them to Gunicorn, which is running

locally on port 8000.



\## Why use nginx?



\- \*\*Keeps Gunicorn private:\*\* Gunicorn listens on `127.0.0.1:8000`, so it is

&#x20; not directly exposed to the internet. Users access the application through

&#x20; nginx on port 80.



\- \*\*Handles incoming HTTP traffic:\*\* Nginx receives requests from clients and

&#x20; passes them to the Flask application through Gunicorn.



\- \*\*Better handling of connections:\*\* Nginx is designed to handle many

&#x20; incoming connections efficiently and can handle things like buffering and

&#x20; slow clients before passing requests to the application.



\- \*\*Adds flexibility:\*\* Nginx can also be used for features such as SSL/TLS

&#x20; termination, serving static files, rate limiting, and load balancing if the

&#x20; application needs them in the future.



\- \*\*Works well with systemd:\*\* In this setup, both nginx and the Flask/Gunicorn

&#x20; application are managed as systemd services, so they can start automatically

&#x20; and be restarted if needed.

