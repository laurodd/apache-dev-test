# datadome-http24-container

Sample server to use Apache module

To specify the version of the DataDome module you want to use, modify the Dockerfile
You can specify advanced options in config/mod_datadome.conf

## Build the docker image

```
docker image build . -t my-apache-with-datadome-module
```

## Run the docker image

Then, to run the docker image, just write:

```
docker run -d --rm --name myApache --env DATADOME_KEY=MY_SERVER_SIDE_DATADOME_KEY -p 8080:80 my-apache-with-datadome-module
```

Then to access logs:

```
docker logs -f myApache
```

Now you can access to the web page using http://localhost:8080/

And once you have finished:

```
docker stop myApache
docker image rm my-apache-with-datadome-module
```
