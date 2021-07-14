# i modify the file because elastic beanstalk doesn't support the build multi-stage
# https://stackoverflow.com/questions/61518512/aws-elastic-beanstalk-docker-does-not-support-multi-stage-build
# FROM node:alpine as builder
FROM node:alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
# /app/build <-- all the stuff that we need will be created into build folder (video number 87)
RUN npm run build

FROM nginx
EXPOSE 80
#i change --from=builder to 0 because the elastic bs build multi-stage error
#COPY --from=builder /app/build /usr/share/nginx/html
COPY --from=0 /app/build /usr/share/nginx/html
