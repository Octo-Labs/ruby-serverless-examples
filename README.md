

## `serverless/`

This is the simplest way to deploy ruby via serverless. The directory was generated with:

```
serverless create -t aws-ruby -p serverless
```

And then the `httpApi` event was uncommented for the `hello` function.

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

Initial Deploy: 1m48.047s
Followup Deploy: 1m11.488s
Deploy only function: 0m5.055s


