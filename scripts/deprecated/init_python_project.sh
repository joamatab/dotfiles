#!/bin/bash

mv python_project/mymodule python_project/{{ project_name }}
mv python_project {{ project_name }}

find {{ project_name }} -name "*" -exec sed -i -n "s/mymodule/{{ project_name }}/g" '{}' \;

# sed -i -e  "s/mymodule/{{ project_name }}/g" {{ project_name }} > /dev/null/ 2>&1

