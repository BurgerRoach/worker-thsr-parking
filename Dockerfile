FROM soumyaray/ruby-http:2.7.2

WORKDIR /worker

COPY / .

RUN bundle install

CMD rake worker