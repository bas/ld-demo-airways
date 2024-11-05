# Steps to make this work:

# Provisioning
1. @bas will do this by the end of *this* week (or next)

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