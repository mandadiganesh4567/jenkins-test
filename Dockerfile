FROM nginx:1.27-alpine
WORKDIR /app
RUN echo"Hi Ganesh" > index.html
COPY index.html /user/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g","daemon off;"]