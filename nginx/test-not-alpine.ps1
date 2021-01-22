Get-Content .\Dockerfile-not-alpine | docker build -t mybuild -
# docker run -itd --name myrun mybuild
# docker exec myrun cat /test.log
# docker stop myrun
# docker rm myrun
