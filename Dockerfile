FROM node:16-alpine as builder 
# everything underneath will belong to the builder phase
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build 
#the build folder (needed for the run phase of the command) will be created in the working directory (/app) => /app/build


# start of the second phase:
# the FROM statement terminates the previous step 
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#  --from=builder means that we want to copy over something from the builder phase
# copy over the build folder into this container
# the default command to start nginx will start nginx for us 




