FROM makevoid/ruby-2.3:latest

# RUN ruby-build 2.3.0-dev /usr/local/ruby-2.3.0-dev
# ENV PATH /usr/local/ruby-2.3.0-dev  /bin:$PATH

RUN mkdir -p /usr/src
ADD . /usr/src/
WORKDIR /usr/src/app

RUN gem install bundler 
RUN bundle install

EXPOSE 8080
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "8080"]
