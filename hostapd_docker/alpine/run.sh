docker stop autowlan && docker rm autowlan
docker run -it --name autowlan --cap-add=NET_ADMIN --network=host -d autowlan
