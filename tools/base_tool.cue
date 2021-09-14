package tools

import (
	"strings"
	"github.com/prometheus/prometheus/pkg/rulefmt"
)

serviceLevelObjectives: [ for v in services for x in v {x}]

prometheusRules: rulefmt.#RuleGroups & {
	groups: [ for slo in serviceLevelObjectives {

		// Get the unique list of short and long window rates
		// TODO: replace with unique() func, asap it's implemented in cue
		_windows: {
			for s in slo.alertWindows {"\( s.short )": s.short}
			for s in slo.alertWindows {"\( s.long )": s.long}
		}
		_windows_unique: [ for i, j in _windows {j}]

		name: "\( slo.service )_\( slo.name )_slo"
		rules: [

			// generate recording rules
			for w in _windows_unique {

				let errors = strings.Replace(slo.errorsQuery, "$__range", w, -1)
				let total = strings.Replace(slo.totalQuery, "$__range", w, -1)

				{
					record: "job:\( slo.service )_\( slo.name )_slo_violations:ratio_rate\( w )"
					expr:   "\( errors ) / \( total )"
					labels: {
						job: slo.service
					}
				}

			},

			// generate alerting rules
			for w in slo.alertWindows {
				{
					alert: slo.alertName
					annotations: {
						description: "High error budget burn for job=\( slo.service ) (current value: {{ $value }})."
						summary:     slo.alertSummary
					}
					for:  w.forPeriod
					expr: "sum(job:\( slo.service )_\( slo.name )_slo_violations:ratio_rate\( w.short )) > (\( w.burn ) * \( 1-slo.threshold )) and sum(job:\( slo.service )_\( slo.name )_slo_violations_total:ratio_rate\( w.long )) > (\( w.burn ) * \( 1-slo.threshold ))"
					labels: {
						job:      slo.service
						severity: w.severity
						long:     w.long
						short:    w.short
					}
				}
			},
		]
	}]
}
