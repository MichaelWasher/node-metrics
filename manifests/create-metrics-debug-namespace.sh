#!/bin/bash

oc new-project metrics-debug
oc adm policy add-scc-to-user privileged -z default
