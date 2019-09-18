This directory contains data that can be used to showcase Data Catalog and scripts that help with the setup of the data.

Steps:
* git clone the repo or copy this source over to a Distrox cluster attached to an environment.
* cd profilers/scripts
* ./replace_vars.sh BUCKET_NAME_WHERE_DATA_WILL_BE_STORED HS2_HOST_NAME
* ./setup_data.sh
* ./run_queries.sh # This runs queries in a loop on the tables setup randomly. Best to run within a screen

What the above steps do:

* The scripts refer to some variables like S3 bucket name and HS2 URL that are environment specific. replace_vars.sh takes these as inputs and replaces all of these in the scripts at appropriate locations.
* Then setup_data.sh creates data directory in the S3 bucket, loads the data using hadoop fs command, then creates Hive tables pointing to them.
* Then, run_queries.sh fires beeline queries in a loop selecting one table at random for every iteration. This will generate audit events that profilers can capture. The periodicity of the run can be adjusted in the script to invoke more or less events. This script runs forever, so it is best run in a screen session so you can log-off from the server.