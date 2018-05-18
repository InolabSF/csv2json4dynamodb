# csv to json converter for dynamodb import


## source csv format

e.g. coutnries.csv

blabla.csv => blabla should be same as dynamodb's table name
 
```
id,country,color,name
N,S,S,S
1,日本,青,サムライブルー
2,エジプト,黄,パラオイエロー
```

N: number, S: string


## convert csv to json

e.g. export coutnries.json

```
$ ruby app.rb coutnries.csv
```


## upload dynamodb

use [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

```
$ aws dynamodb batch-write-item --request-items file://countries.json
```
