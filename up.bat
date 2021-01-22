@ECHO OFF
docker-compose up -d --build
docker exec nginx-1 ls /usr/share/nginx/html