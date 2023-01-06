<div align="center">

## Tea Subscription

[![ruby][ruby]][ruby-url] [![ror][ror]][ror-url] [![Postgres][Postgres]][Postgres-url]

#### Contributors: [Anna Marie Sterling](https://github.com/AMSterling)

</div>

---

## Description

A rails backend API for Tea Subscription

---

# <a name="contents"></a> Table of contents

- [Architecture](#architecture)
- [Database setup](#database-setup)
  - [Required API keys](#required-keys)
- [Endpoints](#endpoints)
  - [Create Subscription](#create-sub)
  - [Cancel Subscription](#cancel-sub)
  - [Fetch Customer Subscriptions](#customer-subs)

---

# <a name="architecture"></a>Architecture

[Back to top](#contents)

# <img src="app/assets/images/schema-diagram.png">

Tea Subscription was built with test-driven development, with Rspec used for testing. It is built with Rails conventions over configuration as a guiding principle. A service-facade design pattern is used when calling external API services.

---

# <a name="database-setup"></a>Database Setup

Instructions to set up a local version of Tea Subscription:

Fork and clone the project, then install the required gems with `bundle`. A full list of gems that will be installed can be found in the [gemfile](gemfile).

```sh
bundle install
```

Reset and seed the database:

```sh
rake db:{drop,create,migrate,seed}
```

## <a name="required-keys"></a> Required keys

Tea Subscription uses <a href="https://spoonacular.com/food-api" target="_blank" rel="noopener noreferrer">Spoonacular API</a>

Once you have your key, set up your environment with

```sh
bundle exec figaro install
```

 Then add your keys to `config/application.yml`:

```ruby
spoonacular_api_key: <YOUR_SPOONACULAR_KEY>
```

Start a rails server, and you're ready to query

```sh
rails s
```

---

# <a name="endpoints"></a>Endpoints

## <a name="create-sub"></a>Create Subscription

[Back to top](#contents)

Creates a new customer subscription.

<br>

```
POST '/api/v1/subscriptions'
```

**Sample body**

 ```
 {
  "title": "Customer's Herbal",
  "price": 15,
  "frequency": "monthly",
  "customer_id": {{customer_id}},
  "tea_id": {{tea_id}}
 }
 ```

**Sample response (status 200)**

 ```
 {
     "data": {
         "id": "1",
         "type": "subscription",
         "attributes": {
             "title": "Customer's Herbal",
             "status": "active",
             "price": 15,
             "frequency": "monthly",
             "tea_id": 1,
             "customer_id": 1
         }
     }
 }
 ```

**Sample body**

 ```
 {
   "title": "",
   "price": 15,
   "frequency": "monthly",
   "customer_id": {{customer_id}},
   "tea_id": {{tea_id}}
 }
 ```

**Sample response (status 422)**

 ```
[
  "Title can't be blank"
]
 ```

---

## <a name="cancel-sub"></a>Cancel Subscription

[Back to top](#contents)

Cancel a customer subscription.

<br>

```
PATCH "/api/v1/subscriptions/#{id}"
```

<br>

**Sample body**

 ```
 {
     "status": 1
 }
 ```

**Sample response (status 200)**

 ```
 {
     "data": {
         "id": "1",
         "type": "subscription",
         "attributes": {
             "title": "Jesus Kunde's Oolong",
             "status": "cancelled",
             "price": 11,
             "frequency": "monthly",
             "tea_id": 1,
             "customer_id": 1
         }
     }
 }
 ```

**Sample body**

 ```
 {
     "status": 2
 }
 ```

**Sample response (status 422)**

 ```
 {
     "error": "'2' is not a valid status"
 }
 ```

---

## <a name="customer-subs"></a>Customer Subscriptions

[Back to top](#contents)

Fetch all subscriptions belonging to a customer.

<br>

```
GET "/api/v1/customers/1/subscriptions"
```

**Sample response (status 200)**

 ```
 {
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Zachery Zboncak's Green",
                "status": "active",
                "price": 12,
                "frequency": "monthly",
                "tea_id": 1,
                "customer_id": 1
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Zachery Zboncak's Oolong",
                "status": "active",
                "price": 13,
                "frequency": "monthly",
                "tea_id": 2,
                "customer_id": 1
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "Zachery Zboncak's Oolong",
                "status": "active",
                "price": 14,
                "frequency": "monthly",
                "tea_id": 3,
                "customer_id": 1
            }
        }
    ]
}
 ```

**Sample response (status 404)**

 ```
 {
    "error": "Couldn't find Customer with 'id'=4168498141546"
 }
 ```

---

<!-- BADGE LINKS -->

[ruby]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[ruby-url]: https://www.ruby-lang.org/en/

[ror]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[ror-url]: https://rubyonrails.org/

[Postgres]: https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/
