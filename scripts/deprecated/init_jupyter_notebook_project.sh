#!/bin/bash

mv jupyter_notebook_project {{ project_name }}
find {{ project_name }} -name "*" -exec sed -i "s/mymodule/{{ project_name }}/g" '{}' \;
