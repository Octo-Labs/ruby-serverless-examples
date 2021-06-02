require 'json'

def hello(event:, context:)
  # Just a meaningless comment.
  {
    statusCode: 200,
    body: {
      message: 'Go Serverless v1.0!!!!! Your function executed successfully!',
      input: event
    }.to_json
  }
end
