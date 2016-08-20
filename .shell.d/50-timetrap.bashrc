#!/bin/bash

# Timetrap -- add a 'switch' option (overriding the old one) to switch between
# sheets.
t()
{
    local mode="$1"
    local sheet="$2"

    if [[ "$mode" == "switch" ]]; then
        if [[ -z "$sheet" ]]; then
            echo >/dev/stderr 'No sheet provided.'
            return 1
        else
            shift; shift;

            command t out "$@" && command t sheet "$sheet" && command t in "$@"
        fi
    else
        command t "$@"
    fi
}
