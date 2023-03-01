--Pull these extensions and provide how many of each website type exist in the accounts table

select distinct(RIGHT(website,3)) from accounts ;
