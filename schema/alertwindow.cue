package schema

#AlertWindow: {
	severity:  "critical" | "error" | "warning" | "info"
	forPeriod: string
	long:      string
	short:     string
	burn:      number
}

#AlertWindows: [...#AlertWindow]

#DefaultAlertWindows: #AlertWindows & [
	{severity: "critical", forPeriod: "2m", long:  "1h", short: "5m", burn:  14.4},
	{severity: "critical", forPeriod: "15m", long: "6h", short: "30m", burn: 6},
	{severity: "warning", forPeriod:  "1h", long:  "1d", short: "2h", burn:  3},
	{severity: "warning", forPeriod:  "3h", long:  "3d", short: "6h", burn:  1},
]
