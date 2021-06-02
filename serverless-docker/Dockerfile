# Use the image that Amazon provides for Lamda ruby
FROM public.ecr.aws/lambda/ruby:2.7

# First we copy just these files so that if they haven't changed the
# Docker layer will be cached and we won't have to re-run `bundle install`
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

# Set some options for bundler
RUN bundle lock --add-platform x86_64-linux
RUN bundle config --local deployment true
RUN bundle config --local without 'development test'
RUN bundle config --local path './vendor/bundle'

# Then isntall our gems
RUN bundle install --quiet --jobs 4

# Copy our entire app into the container.
# Anything listed in .dockerignore will not be copied.
COPY . .

# And finally we have the CMD for the deployed container
# You can overwrite command in `serverless.yml` template
CMD [ "app.LambdaFunction::Handler.process" ]


