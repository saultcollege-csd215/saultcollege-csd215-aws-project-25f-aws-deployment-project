Why we use Nginx as a reverse proxy

We use Nginx as a reverse proxy because it helps our Flask app run more stable and safe. The Flask/Gunicorn server is good for running Python code, but not so good for handling internet traffic directly. Nginx stay in the front and receives all the requests first, then it send them to the app on port 8000.

Nginx is faster at dealing with many connections and it also makes easier to use port 80, since the app alone sometimes can't do that very well. It also can manage some things like buffering and headers that the app don't handle so good.

Basically, Nginx works like a “middle layer” that protects and organize the traffic before it reaches the Python app. Even this project is small, using Nginx makes it feel more close to real production setup.