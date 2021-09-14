# example_http_requests_errors.cue

```
package tools

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
