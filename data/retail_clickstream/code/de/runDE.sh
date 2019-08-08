spark-submit --conf spark.yarn.access.hadoopFileSystems=s3a://cloudbreak-group Tokenizer.py
beeline -n csso_eqbr -p Cloudera1! -f createTable.sql
