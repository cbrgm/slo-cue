#!/usr/bin/env bash
# Regenerate all definition from latest releases, including the dummy Go module which is used to pin dependencies.

rm -rf go.mod cue.mod/gen

# Pin Go dependencies
go mod init github.com/cbrgm/slo-cue
go mod tidy

# Generate Cue definitions (see deps.go)
cue get go github.com/prometheus/prometheus/pkg/rulefmt
