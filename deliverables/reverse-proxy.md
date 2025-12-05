# Purpose and benefits of uning nginx as a reverse proxy

In this lab, nginx (working as a reverse proxy) handles the initial connection and then it can handle static files, but in this case we don't have static files.
So in this lab nginx is only working as a reverse proxy, which means that it receives the user requests on the specified port (80), and it forwards the requests to gunicorn.
Then, Gunicorn will give the request to the flask app, and return back a response to nginx, which will then send back the response to the user.

All this is important in the lab first of all for security, the only thing exposed to the internet is nginx, not gunicorn (which is the one actually handling the application logic). Performance is another important thing that nginx will help a lot, in the case of the lab probablyy won't be necessary because we won't have thousands of users but nginx could handle them.
And scalability, if we wanted to add a nice user interface or some helpful static files, nginx is already configured for it and would serve them directly. 
