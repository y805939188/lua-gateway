#!/usr/bin/env bash

resty -I ../lua busted_runner.lua --verbose --coverage -- test_spec.lua

luacov ../lua

tail -n 20 luacov.report.out