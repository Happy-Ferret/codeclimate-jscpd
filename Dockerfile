FROM mhart/alpine-node

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN apk --update add git ruby ruby-dev ruby-bundler python g++ make && \
    bundle install -j 4 && \
    npm install jscpd -g && \
    apk del make g++ && rm -fr /usr/share/ri


RUN adduser -u 9000 -D app
COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app
CMD "ruby" "/usr/src/app/bin/jscpd"
