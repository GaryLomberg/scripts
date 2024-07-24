#!/bin/env bash
#must be run with source in order to activate the virtual environment

project_name=$1
all_projects_directory="$HOME/Projects/"
projects_dir=$(realpath -m "$all_projects_directory/$project_name")

venv_dir=$(find $projects_dir -type f -name "pyvenv.cfg" | xargs dirname)
npm_dir=$(find $projects_dir -maxdepth 2 -type f -name "package.json" | xargs dirname)

# activate venv
if [ -d $venv_dir ]; then
	activation_script=$(realpath -m "$venv_dir/bin/activate")
	source $activation_script
fi

cd "$npm_dir"
npm run dev
