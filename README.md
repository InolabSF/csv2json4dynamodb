# csv to json converter for dynamodb import


## source csv format

e.g. coutnries.csv
 
```
id,name
N,S
1,Japan
2,Korea
```

N: number
S: string


## convert csv to json

e.g. export coutnries.json

```
$ ruby app.rb coutnries.csv
```
