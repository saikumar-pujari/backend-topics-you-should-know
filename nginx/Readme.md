# NGINX COMPLETE GUIDE (ZERO → PRODUCTION)

Author: Generated guide for backend developers\
Purpose: Understand Nginx from basics to real production deployments
(Django, Docker, AWS).

------------------------------------------------------------------------

# 1. What is Nginx

Nginx (pronounced **Engine-X**) is a high‑performance **web server,
reverse proxy, and load balancer**.

It is widely used in production systems to:

-   Serve static files
-   Reverse proxy requests to backend servers
-   Load balance traffic
-   Handle HTTPS/SSL
-   Improve performance and security

Example architecture:

User → Nginx → Gunicorn/Uvicorn → Django/FastAPI → Database

------------------------------------------------------------------------

# 2. Why Nginx is Used

Without Nginx:

User → Django → Database

Problems: - Django handles too many connections - Static files are
slow - Hard to scale - No SSL termination

With Nginx:

User ↓ Nginx ↓ Gunicorn / Uvicorn ↓ Django ↓ Database

Nginx becomes the **traffic controller**.

------------------------------------------------------------------------

# 3. Real Production Architecture

Typical backend production stack:

Internet ↓ DNS ↓ Nginx ↓ Gunicorn ↓ Django ↓ PostgreSQL ↓ Redis ↓ Celery

------------------------------------------------------------------------

# 4. Core Responsibilities of Nginx

1.  Static file server
2.  Reverse proxy
3.  Load balancing
4.  SSL termination
5.  Security gateway

------------------------------------------------------------------------

# 5. Installing Nginx (Linux)

sudo apt update sudo apt install nginx

Start service:

sudo systemctl start nginx

Check status:

sudo systemctl status nginx

Test in browser:

http://server-ip

------------------------------------------------------------------------

# 6. Nginx Directory Structure

/etc/nginx/

Structure:

/etc/nginx │ ├── nginx.conf ├── sites-available ├── sites-enabled ├──
conf.d └── snippets

Logs:

/var/log/nginx/

Files:

access.log\
error.log

------------------------------------------------------------------------

# 7. Main Nginx Configuration File

/etc/nginx/nginx.conf

Example:

events { worker_connections 1024; }

http {

    server {

        listen 80;

        location / {
            root /usr/share/nginx/html;
            index index.html;
        }

    }

}

------------------------------------------------------------------------

# 8. Nginx Block Types

events → connection handling\
http → http server configuration\
server → website configuration\
location → request routing

Example:

server { listen 80; }

location / { root /var/www/html; }

------------------------------------------------------------------------

# 9. Reverse Proxy Example

Backend running:

127.0.0.1:8000

Config:

/etc/nginx/sites-available/app.conf

server {

    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
    }

}

Enable site:

sudo ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/

Reload nginx:

sudo systemctl reload nginx

------------------------------------------------------------------------

# 10. Request Flow

User request:

http://example.com/api/users

Flow:

Browser ↓ Nginx ↓ Gunicorn ↓ Django

------------------------------------------------------------------------

# 11. Static File Serving

Example configuration:

location /static/ { alias /home/ubuntu/project/static/; }

Flow:

Browser → Nginx → Static File

Django is not used for static files.

------------------------------------------------------------------------

# 12. Load Balancing

Example:

upstream backend {

    server 127.0.0.1:8000;
    server 127.0.0.1:8001;
    server 127.0.0.1:8002;

}

server {

    location / {
        proxy_pass http://backend;
    }

}

Traffic is distributed across servers.

------------------------------------------------------------------------

# 13. Rate Limiting

limit_req_zone \$binary_remote_addr zone=api:10m rate=5r/s;

location /api/ { limit_req zone=api; }

Meaning: maximum 5 requests per second per IP.

------------------------------------------------------------------------

# 14. SSL / HTTPS

SSL encrypts communication between client and server.

HTTP:

http://example.com

HTTPS:

https://example.com

SSL files:

fullchain.pem\
privkey.pem

Example Nginx config:

server {

    listen 443 ssl;

    server_name example.com;

    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

    location / {
        proxy_pass http://127.0.0.1:8000;
    }

}

------------------------------------------------------------------------

# 15. HTTP → HTTPS Redirect

server {

    listen 80;

    server_name example.com;

    return 301 https://$host$request_uri;

}

------------------------------------------------------------------------

# 16. Generate SSL using Certbot

Install:

sudo apt install certbot python3-certbot-nginx

Generate certificate:

sudo certbot --nginx -d example.com

Certificates stored in:

/etc/letsencrypt/live/example.com/

------------------------------------------------------------------------

# 17. Docker + Nginx Deployment

Project structure:

project/ │ ├── docker-compose.yml ├── Dockerfile ├── nginx/ │ └──
nginx.conf └── app/

Example nginx config:

location / { proxy_pass http://web:8000; }

------------------------------------------------------------------------

# 18. Docker Compose Example

version: "3"

services:

web: build: . command: gunicorn project.wsgi:application --bind
0.0.0.0:8000

nginx: image: nginx ports: - "80:80" volumes: -
./nginx/nginx.conf:/etc/nginx/nginx.conf

------------------------------------------------------------------------

# 19. Nginx Logs

Location:

/var/log/nginx/

Commands:

tail -f /var/log/nginx/access.log tail -f /var/log/nginx/error.log

------------------------------------------------------------------------

# 20. Testing Config

Always test before restart:

sudo nginx -t

Reload config:

sudo systemctl reload nginx

------------------------------------------------------------------------

# 21. Debugging Nginx

Check service:

systemctl status nginx

Check open ports:

sudo ss -tulnp

------------------------------------------------------------------------

# 22. Performance Tips

Use gzip compression:

gzip on;

Use worker auto scaling:

worker_processes auto;

Use caching:

proxy_cache

------------------------------------------------------------------------

# 23. Nginx vs Apache

Feature \| Nginx \| Apache Architecture \| Event‑driven \| Thread-based
Performance \| High \| Moderate Static Files \| Excellent \| Good

------------------------------------------------------------------------

# 24. Production Best Practices

Always:

-   use HTTPS
-   use reverse proxy
-   serve static via Nginx
-   use load balancing
-   monitor logs

------------------------------------------------------------------------

# 25. Final Architecture

Client ↓ Nginx ↓ Gunicorn ↓ Django ↓ Database ↓ Redis ↓ Celery

Nginx becomes the **front door of your backend infrastructure**.

------------------------------------------------------------------------

END OF GUIDE
