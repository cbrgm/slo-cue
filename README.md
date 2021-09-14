# SLO CUE

Generate Prometheus alerting & recording rules for SLOs with CUE.

__Highly experimental!__

## Usage

First, a service must be defined with associated SLOs.

```cue
import (
	"github.com/cbrgm/slo-cue/schema"
)

services: schema.#ServiceDefinition

services: "bar_service": [
	{
		name:        "requests"
		errorsQuery: "sum(rate(promhttp_metric_handler_requests_total{namespace='default',job='fooapp',code=~'5..'}[$__range]))"
		totalQuery:  "sum(rate(promhttp_metric_handler_requests_total{namespace='default',job='fooapp'}[$__range]))"
		threshold:   0.999

		alertWindows: schema.#DefaultAlertWindows
	},
]
```


This service definition must be saved in the `tools` folder. 

Dump the [Prometheus](https://prometheus.io) Alerting & Recording Rules as JSON.

```
cd tools && cue dumpjson
```

or as yaml

```
cd tools && cue dump
```

## Acknowledgements

This project was inspired by

* [metalmatze/slo-libsonnet](https://github.com/metalmatze/slo-libsonnet) by [@metalmatze](https://github.com/metalmatze)
* [https://github.com/codesome/prometheus-slo](https://github.com/codesome/prometheus-slo) by [@codesome](https://github.com/codesome)

Literature:

* [Implementing Service Level Objectives](https://www.oreilly.com/library/view/implementing-service-level/9781492076803/); Alex Hidalgo; O'Reilly Media, Inc., 2020; ISBN: 9781492076810
* [Google SRE: Alerting on SLOs](https://sre.google/workbook/alerting-on-slos/); Steven Thurgood et al.

## Contributing & License

Feel free to submit changes! See the [Contributing Guide](https://github.com/cbrgm/contributing/blob/master/CONTRIBUTING.md). This project is open-source and is developed under the terms of the [Apache 2.0 License](https://github.com/cbrgm/slo-cue/blob/master/LICENSE).


