# Ruby Serverless Examples

The repo contains several different examples of how you can deploy Ruby to
[AWS Lambda](https://aws.amazon.com/lambda/) via
[serverless](https://www.serverless.com/).

Each approach has some pros and cons. Generally you'll probably want to choose the lightest approach
possible for the workload you need to support.

Once you have `serverless` configured and working you can deploy any of these examples
by `cd`ing into the appropriate directory and doing `serverless deploy`.

For instance:
```
cd serverless-docker
serverless deploy
```

## `serverless/`

This is the simplest way to deploy ruby via serverless. You don't get any built-in support for including
gems, but things are very fast to deploy. Using `serverless deploy function` you can skip deploying the
entire CloudFormation template and update the function code directly, which is pretty fast. Usually just
a few seconds.

The directory was generated with:

```
serverless create -t aws-ruby -p serverless
```

And then the `httpApi` event was uncommented for the `hello` function.

Pros:
* lightweight
* fastest cold boot
* fast function deploys

Cons:
* no built-in support for gems or a `Gemfile`
* no built-in support for gems requiring native compliation
* no built-in local access to a production-like runtime

Deployment timing:
* Initial Deploy: 1m46.474s
* Followup Deploy: 0m50.188s
* Deploy only function: 0m4.188s

## 'ruby-layer/`

This uses `serverless-ruby-layer` to automatically bundle gems based on a `Gemfile`. Those gems
are then packaged into a layer(https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html)
which is used by the function. The layer is separate from the function code itself, so if you change your
function but don't change the `Gemfile` you can use `serverless deploy function` to deploy only your function
without needing to `bundle install` which will be pretty fast.

```
serverless create -t aws-ruby -p serverless
sls plugin install -n serverless-ruby-layer
```

And then the `httpApi` event was uncommented for the `hello` function. And a basic `Gemfile` was
added that only specifies a ruby version.

Pros:
* still fairly lightweight
* fairly fast cold boot
* built-in support for gems via `Gemfile`
* fast function deploys

Cons:
* no built-in support for gems requiring native compliation
* no built-in local access to a production-like runtime

Deployment timing:
* Initial Deploy: 1m48.047s
* Followup Deploy: 1m11.488s
* Deploy only function: 0m5.055s

# `ruby-layer-docker/`

This is very similar to the `ruby-layer` example but it uses Docker to create the bundled gems which is
useful if you have a gem that requires native compliation for the target dployment platform (like `pg`
or `mysql2`). The bundled gems are again deployed in a layer, and not with the function itself, which means
that deploying a single function is still pretty fast, even if Docker does slow down the layer packing a bit.

Copied the `ruby-layer` project and added a `custom` section to activate Docker for `serverless-ruby-layer`.

Pros:
* still reasonably lightweight depending on gems required
* built-in support for gems via `Gemfile`
* built-in support for gems requiring native compliation

Cons:
* no built-in local access to a production-like runtime



Deployment timing:
* Initial Deploy: 2m13.048s
* Followup Deploy: 1m24.996s
* Deploy only function: 0m3.823s

## `serverless-docker/`

This uses ECR to deploy a Docker container to Lambda. This is the most heavyweight option. You're building
a full Docker image that is pushed to ECR, whcih is then deployed by Lambda. The plus side is that you can
have local access to your deployment environment, and it's a handy way to be able to install additional
packages or custom binaries to your runtime environment.

Pros:
* built-in support for gems via `Gemfile`
* built-in support for gems requiring native compliation
* built-in local access to a production-like runtime

Cons:
* not lightweight
* slower to deploy the whole project
* slower to deploy a single function

Deployment timing:
* Initial Deploy: 3m13.384s
* Followup Deploy: 1m14.361s
* Deploy only function: 0m24.165s

