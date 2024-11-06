# Steps to make this work

## Introduction

This demo is an adapation of the Launch Airways demo allowing you to demo the OpenTelemetry integration. 

## Provisioning

### Provision the project

1. Clone this repository to your local machine
2. Make sure you have an [Access Token](https://docs.launchdarkly.com/home/account/api-create) with Write permission
3. Make sure you have [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
4. In the repository navigate to the `terraform` folder
5. Run `terraform apply` and provide the requested access token and a project name. As a project name use for example `<username>-demo-airways`
6. Check if your project exists in LaunchDarkly

### Update environment settings

1. In your local repository create a `.env.local` from the `.env.example`
2. Add the SDK client and server keys from your project, your project and the environemnt you connect to
3. Use the Redis and Database url's from [Release Guardian Demo - Launch Airways](https://launchdarkly.atlassian.net/wiki/spaces/LaunchX/pages/2835218907/Release+Guardian+Demo+-+Launch+Airways)

## Implementation
1. Configure the LD SDK to decorate OTEL span events (hook - see `./utils/ld-server/serverClient.ts` for example)
2. Configure the exporter in Open Telemetry to filter out events that should are not flag evaluations (done in `otel-collector-config.yaml`. docs on how to set up OTel to send traces to LD: https://docs.launchdarkly.com/sdk/features/opentelemetry)
3. Create metrics in LD that will represent ^^ traces/span events (instructions on metric definition: https://docs.launchdarkly.com/integrations/opentelemetry#create-launchdarkly-metrics-from-opentelemetry-trace-data)

## Run the demo
1. Start the Open Telemetry collector
   1. Start Docker daemon
   2. `docker compose up` from the project root
   3. Visit `localhost:16686` to access to Jaeger UI
2. Start the Demo application (Launch Airways)
   1. (`npm install` if not run already earlier)
   2. `npm run dev` - the app needs to start *after* OTEL collector has started
3. Check in Jaeger if LD Airways app is showing under the available services: `ld-demo-airways`
4. Reconfigure the guarded rollout on the **Enable Fast Cache** flag
   1. Target friends & family segment, select 5xx error & latency as metrics
5. Run the simulateTraffic.sh from the terminal (`./simulateTraffic.sh`)
6. Monitor the Guarded Rollout results until the regression is detected
