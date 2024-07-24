#!/bin/env bash
#must be run with source in order to activate the virtual environment

project_name=$1
dj_command=${2:="runserver 0:8000"}

all_projects_directory="$HOME/Projects/"
projects_dir=$(realpath -m "$all_projects_directory/$project_name")

venv_dir=$(find $projects_dir -type f -name "pyvenv.cfg" | xargs dirname)
manage_file=$(find $projects_dir -type f -name "manage.py")
manage_dir=$(dirname $manage_file)

echo "$manage_file"

# activate venv
if [ -d $venv_dir ]; then
	activation_script=$(realpath -m "$venv_dir/bin/activate")
	source $activation_script
fi

cd $manage_dir
python $manage_file $dj_command
