In this lab, nginx serves as a reverse proxy between the internet and the Flask app running on the EC2 instance.  The Flask app
is not directly exposed to the internet but nginx is as it is listening on port 80.  Nginx forwards HTTP requests to the Flask 
app and then sends responses back to the client.  Nginx is a production grade server but Flask's built in dev server is not.
Nginx in front of Flask makes it more efficient and secure.  So overall, nginx provides improved efficiency, security, HTTP
handling, and scalability.