package tools

import (
	"encoding/yaml"
	"encoding/json"
	"tool/cli"
)

command: {
	dump: {
		print: cli.Print & {
			text: yaml.Marshal(prometheusRules)
		}
	}

	dumpjson: {
		print: cli.Print & {
			text: json.Marshal(prometheusRules)
		}
	}

}
