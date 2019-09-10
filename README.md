# cdp-demo

## Setup roles, instance profiles for IDBroker
IDBroker enabled SDX and DistroX clusters requires that AWS roles, instance profiles and the necessary trust relationship is set up between them.

## Setup environment
Set up the environment using mow-dev. All configuration done through UI. The scripts in scripts/environment are there for reference purposes

Create two clusters: One with DE template and one with DW.

## Run workloads
<code>
cd scripts/workload-scripts
</code>

### Copy data 
#### Copy data to the data engineering cluster host and then to S3
<code>
scp -r ../../data/retail_clickstream adam@${hostname}:/tmp/
  
ssh adam@${hostname} 'bash -s' < copyData.sh ${datalake_root}
</code>

### Give permissions to data_eng for retail_clickstream in Ranger
Todo: We need to get the policy export/import from ranger

### Ssh to DE cluster and run the de scripts
<code>
scp -r de adam@${hostname}:~/
  
scp -r dm adam@${hostname}:~/

ssh adam@${hostname}

cd de

chmod u+x runDE.sh

</code>
Change the datalake name in Tokenizer.py and createProdTables.sql appropriately
<code>
./runDE.sh
</code>

### Success if this command runs and returns the top 10 products
<code>
ssh adam@${hostname} 'beeline -f dm/bi_query.sql'
</code>

## Hacks and workarounds
A live running document is located here: https://docs.google.com/document/d/10wAw5-HQNFEX96x-YhfUZUL2-2O3eh1dHtYxxfR97hE/edit#



