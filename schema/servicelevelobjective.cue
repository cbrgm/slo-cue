package schema

#ServiceLevelObjective: {

	// name is the SLO name
	name: string

	// service describes the service name
	service: string

	// alertName is the alert name for error budget burn alerts
	alertName: string | *"ErrorBudgetBurn"

	// alertSummary is the summary for slo alerts
	alertSummary: string | *"High error budget burn."

	// alertWindows is a list of burn rates and time windows
	alertWindows: [...#AlertWindow]

	// errorsQuery is a PromQL query returning the count of requests not fulfilling the SLO
	// Important: You must put $__range for the range in the range selector.
	errorsQuery: string

	// totalQuery is a PromQL query returning the total count of requests.
	// Important: You must put $__range for the range in the range selector.
	totalQuery: string

	// threshold describes quantile values in terms of %, for example: 99.9, 99.95, 99.0
	threshold: number
}
