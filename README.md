# kaigi on rails 2024

kaigi on rails 2024の資料を作成するときに動作確認を行うためのアプリです。

## run
```
$ rails db:setup
$ rails s
```

## sample query
access to [http://localhost:3000/graphiql](http://localhost:3000/graphiql)
```graphql
{
  orders {
    id
    customer {
      name
      id
      isLoyal
    }
  }
}
```
