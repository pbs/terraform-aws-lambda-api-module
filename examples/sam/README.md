# Fun Little Hack

SAM (Serverless Application Model) from AWS allows you to run Lambdas locally as APIs even if you don't use it for IAC.

## Install

```bash
brew tap aws/tap
brew install aws-sam-cli
```

You'll also need Docker installed.

## Run

```bash
sam local start-api -v ../artifacts
```

You'll be able to access the lambda as an API @ localhost:3000/status
