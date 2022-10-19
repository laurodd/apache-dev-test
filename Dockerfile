FROM httpd:2.4

RUN apt-get update
RUN apt-get -y install make wget libssl-dev apache2-dev

RUN apt-get install -y procps
RUN apt-get install -y vim

#COMPILING MODULE
COPY ./ApacheDome ./DataDome-ApacheDome
RUN make -C ./DataDome-ApacheDome prepare
RUN make -C ./DataDome-ApacheDome
RUN make -C ./DataDome-ApacheDome install


# Activate mod_ssl for DataDome
RUN sed -i 's/#LoadModule ssl_module modules\/mod_ssl.so/LoadModule ssl_module modules\/mod_ssl.so/g' /usr/local/apache2/conf/httpd.conf

# If you want use the config file from the root directory
COPY ./config/mod_datadome.conf /usr/local/apache2/conf/extra/

# else you want to use the default configuration file ...

#RUN cp DataDome-ApacheDome*/docs/mod_datadome.conf /usr/local/apache2/conf/extra/

# Switch to variable env for DATADOME Key
#RUN sed -i 's/"SETYOURDATADOMEKEY"/\$\{DATADOME_KEY\}/g' /usr/local/apache2/conf/extra/mod_datadome.conf

RUN echo 'Include conf/extra/mod_datadome.conf' >> /usr/local/apache2/conf/httpd.conf

# If you need to configure your httpd.conf
#using in to add Datadome logs in DEV
COPY ./config/my-httpd.conf /usr/local/apache2/conf/httpd.conf

# If you need to upload an app
#COPY ./webcontent/ /usr/local/apache2/htdocs/
