#!/bin/bash

tables=(plans colors predictions quizzes smalltalks)

for table in ${tables[@]}; do
    aws dynamodb scan --table-name $table --attributes-to-get "id" --query "Items[].id.N" --output text | tr "\t" "\n" | xargs -t -I keyvalue aws dynamodb delete-item --table-name $table --key '{"id": {"N": "keyvalue"}}'

    ruby app.rb $table.csv

    i=0
    under_score='_'
    while : ; do
        filename=$table$under_score$i.json
        if [ -e $filename ]; then
            echo $filename
            aws dynamodb batch-write-item --request-items file://$filename
        else
            break
        fi
        let i++
    done
done
