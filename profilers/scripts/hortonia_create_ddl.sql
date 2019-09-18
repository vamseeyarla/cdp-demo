 CREATE EXTERNAL TABLE IF NOT EXISTS `us_customers`(                                                 
   `number` string,                                                                        
   `gender` string,                                                                        
   `title` string,                                                                         
   `givenname` string,                                                                     
   `middleinitial` string,                                                                 
   `surname` string,                                                                       
   `streetaddress` string,                                                                 
   `city` string,                                                                          
   `state` string,                                                                         
   `statefull` string,                                                                     
   `zipcode` string,                                                                       
   `country` string,                                                                       
   `countryfull` string,                                                                   
   `emailaddress` string,                                                                  
   `username` string,                                                                      
   `password` string,                                                                      
   `telephonenumber` string,                                                               
   `telephonecountrycode` string,                                                          
   `mothersmaiden` string,                                                                 
   `birthday` string,                                                                      
   `age` int,                                                                              
   `tropicalzodiac` string,                                                                
   `cctype` string,                                                                        
   `ccnumber` string,                                                                      
   `cvv2` string,                                                                          
   `ccexpires` string,                                                                     
   `nationalid` string,                                                                    
   `mrn` string,                                                                           
   `insuranceid` string,                                                                   
   `eyecolor` string,                                                                      
   `occupation` string,                                                                    
   `company` string,                                                                       
   `vehicle` string,                                                                       
   `domain` string,                                                                        
   `bloodtype` string,                                                                     
   `weight` double,                                                                        
   `height` int,                                                                           
   `latitude` double,                                                                      
   `longitude` double)                                                                     
 ROW FORMAT SERDE                                                                          
   'org.apache.hadoop.hive.ql.io.orc.OrcSerde'                                             
 STORED AS INPUTFORMAT                                                                     
   'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'                                       
 OUTPUTFORMAT                                                                              
   'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'                                      
 LOCATION                                                                                  
   's3a://REPLACE_BUCKET_NAME_HERE/data/hortonia_bank/security/apps/hive/warehouse/hortoniabank.db/us_customers'  
 TBLPROPERTIES (                                                                           
   'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',                                   
   'numFiles'='1',                                                                         
   'numRows'='50000',                                                                      
   'rawDataSize'='158450000',                                                              
   'totalSize'='5669920',                                                                  
   'transient_lastDdlTime'='1472449244',
   'department'='Insurance Claims');                                                   

 CREATE EXTERNAL TABLE  IF NOT EXISTS `ww_customers`(                                                 
   `gender` string,                                                                        
   `title` string,                                                                         
   `givenname` string,                                                                     
   `middleinitial` string,                                                                 
   `surname` string,                                                                       
   `number` int,                                                                           
   `nameset` string,                                                                       
   `streetaddress` string,                                                                 
   `city` string,                                                                          
   `state` string,                                                                         
   `statefull` string,                                                                     
   `zipcode` string,                                                                       
   `country` string,                                                                       
   `countryfull` string,                                                                   
   `emailaddress` string,                                                                  
   `username` string,                                                                      
   `password` string,                                                                      
   `telephonenumber` string,                                                               
   `telephonecountrycode` int,                                                             
   `mothersmaiden` string,                                                                 
   `birthday` string,                                                                      
   `age` int,                                                                              
   `tropicalzodiac` string,                                                                
   `cctype` string,                                                                        
   `ccnumber` bigint,                                                                      
   `cvv2` int,                                                                             
   `ccexpires` string,                                                                     
   `nationalid` string,                                                                    
   `mrn` bigint,                                                                           
   `insuranceid` int,                                                                      
   `eyecolor` string,                                                                      
   `occupation` string,                                                                    
   `company` string,                                                                       
   `vehicle` string,                                                                       
   `domain` string,                                                                        
   `bloodtype` string,                                                                     
   `weight` double,                                                                        
   `height` int,                                                                           
   `latitude` double,                                                                      
   `longitude` double)                                                                     
 ROW FORMAT SERDE                                                                          
   'org.apache.hadoop.hive.ql.io.orc.OrcSerde'                                             
 STORED AS INPUTFORMAT                                                                     
   'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'                                       
 OUTPUTFORMAT                                                                              
   'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'                                      
 LOCATION                                                                                  
   's3a://REPLACE_BUCKET_NAME_HERE/data/hortonia_bank/security/apps/hive/warehouse/hortoniabank.db/ww_customers'  
 TBLPROPERTIES (                                                                           
   'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',                                   
   'numFiles'='1',                                                                         
   'numRows'='50000',                                                                      
   'rawDataSize'='137100000',                                                              
   'totalSize'='6096763',                                                                  
   'transient_lastDdlTime'='1473204580',
   'department'='Insurance Claims');   
                                                   
 CREATE EXTERNAL TABLE  IF NOT EXISTS `eu_countries`(                                                 
   `countryname` string,                                                                   
   `countrycode` string,                                                                   
   `region` string)                                                                        
 ROW FORMAT SERDE                                                                          
   'org.apache.hadoop.hive.ql.io.orc.OrcSerde'                                             
 STORED AS INPUTFORMAT                                                                     
   'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'                                       
 OUTPUTFORMAT                                                                              
   'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'                                      
 LOCATION                                                                                  
   's3a://REPLACE_BUCKET_NAME_HERE/data/hortonia_bank/security/apps/hive/warehouse/hortoniabank.db/eu_countries'  
 TBLPROPERTIES (                                                                           
   'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',                                   
   'numFiles'='1',                                                                         
   'numRows'='28',                                                                         
   'rawDataSize'='7364',                                                                   
   'totalSize'='697',                                                                      
   'transient_lastDdlTime'='1472453725');                                                  

 CREATE EXTERNAL TABLE  IF NOT EXISTS `tax_2015`(                                                 
   `ssn` string,                                                                  
   `fed_tax` int,                                                                 
   `state_tax` int,                                                               
   `local_tax` int)                                                               
 ROW FORMAT SERDE                                                                 
   'org.apache.hadoop.hive.ql.io.orc.OrcSerde'                                    
 STORED AS INPUTFORMAT                                                            
   'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'                              
 OUTPUTFORMAT                                                                     
   'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'                             
 LOCATION                                                                         
   's3a://REPLACE_BUCKET_NAME_HERE/data/hortonia_bank/security/apps/hive/warehouse/finance.db/tax_2015'  
 TBLPROPERTIES (                                                                  
   'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',                          
   'numFiles'='1',                                                                
   'numRows'='3',                                                                 
   'rawDataSize'='321',                                                           
   'totalSize'='574',                                                             
   'transient_lastDdlTime'='1472456231');                                          

 CREATE EXTERNAL TABLE  IF NOT EXISTS `provider_summary`(                 
   `providerid` string,                                          
   `providername` string,                                        
   `providerstreetaddress` string,                               
   `providercity` string,                                        
   `providerstate` string,                                       
   `providerzip` string,                                         
   `providerreferralregion` string,                              
   `totaldischarges` int,                                        
   `averagecoveredcharges` decimal(10,2),                        
   `averagetotalpayments` decimal(10,2),                         
   `averagemedicarepayments` decimal(10,2))                      
 COMMENT 'Provider Summary'                                      
 ROW FORMAT DELIMITED                                            
   FIELDS TERMINATED BY ','                                      
 STORED AS INPUTFORMAT                                           
   'org.apache.hadoop.mapred.TextInputFormat'                    
 OUTPUTFORMAT                                                    
   'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'  
 LOCATION                                                        
   's3a://REPLACE_BUCKET_NAME_HERE/data/hortonia_bank/security/source/claim'            
 TBLPROPERTIES (                                                 
   'numFiles'='1',                                               
   'totalSize'='16132',                                          
   'transient_lastDdlTime'='1474444382',
   'department'='Insurance Claims');

 CREATE EXTERNAL TABLE IF NOT EXISTS `claim_savings`(             
   `reportdate` date,                                            
   `name` string,                                                
   `sequenceid` int,                                             
   `claimid` int,                                                
   `costsavings` int,                                            
   `eligibilitycode` int,                                        
   `latitude` decimal(10,0),                                     
   `longitude` decimal(10,0))                                    
 COMMENT 'Claims Savings'                                        
 ROW FORMAT DELIMITED                                            
   FIELDS TERMINATED BY ','                                      
 STORED AS INPUTFORMAT                                           
   'org.apache.hadoop.mapred.TextInputFormat'                    
 OUTPUTFORMAT                                                    
   'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'  
 LOCATION                                                        
   's3a://REPLACE_BUCKET_NAME_HERE/data/hortonia_bank/security/dev/cost_savings'        
 TBLPROPERTIES (                                                 
   'numFiles'='1',                                               
   'totalSize'='6830',                                           
   'transient_lastDdlTime'='1474439132',
   'department'='Insurance Claims');
 