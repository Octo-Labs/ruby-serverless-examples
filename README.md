# Ruby Serverless Examples

The repo contains several different examples of how you can deploy Ruby to
[AWS Lambda](https://aws.amazon.com/lambda/) via
serverless(https://www.serverless.com/).

Each approach has some pros and cons. Generally you'll probably want to choose the lightest approach
possible for the workload you need to support.

## `serverless/`

This is the simplest way to deploy ruby via serverless. The directory was generated with:

```
serverless create -t aws-ruby -p serverless
```

And then the `httpApi` event was uncommented for the `hello` function.

Pros:
* lightweight
* fastest cold boot

Cons:
* no built-in support for gems or a `Gemfile`
* no built-in support for gems requiring native compliation
* no built-in local access to a production-like runtime

Initial Deploy: 1m46.474s
Followup Deploy: 0m50.188s
Deploy only function: 0m4.188s

## 'ruby-layer/`

This uses `serverless-ruby-layer` to automatically bundle gems based on a `Gemfile`. Those gems
are then included in the deployed function.

```
serverless create -t aws-ruby -p serverless
sls plugin install -n serverless-ruby-layer
```

And then the `httpApi` event was uncommented for the `hello` function. And a basic `Gemfile` was
added that only specifies a ruby version.

Pros:
* still fairly lightweight
* built-in support for gems via `Gemfile`

Cons:
* no built-in support for gems requiring native compliation
* no built-in local access to a production-like runtime

Initial Deploy: 1m48.047s
Followup Deploy: 1m11.488s
Deploy only function: 0m5.055s

# `ruby-layer-docker/`

Copied the `ruby-layer` project and added a `custom` section to activate Docker for `serverless-ruby-layer`.

Pros:
* still reasonably lightweight depending on gems required
* built-in support for gems via `Gemfile`
* built-in support for gems requiring native compliation

Cons:
* no built-in local access to a production-like runtime



Initial Deploy: 2m13.048s
Followup Deploy: 1m24.996s
Deploy only function: 0m3.823s

## `serverless-docker/`

This uses ECR to deploy a Docker container to Lambda.

Pros:
* built-in support for gems via `Gemfile`
* built-in support for gems requiring native compliation
* built-in local access to a production-like runtime

Cons:
* not lightweight
* slower to deploy the whole project
* slower to deploy a single function

Initial Deploy: 3m13.384s
Followup Deploy: 1m14.361s
Deploy only function: 0m24.165s

