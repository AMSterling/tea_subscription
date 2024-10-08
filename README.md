<div align="right">

[![Maintainability](https://api.codeclimate.com/v1/badges/c6fbbe6ac8671bb65dcd/maintainability)](https://codeclimate.com/github/AMSterling/tea_subscription/maintainability)

</div>

<div align="center">

# Tea Subscription

  <p>
    <a href="https://github.com/AMSterling/tea_subscription">
      <img src="https://media.giphy.com/media/WQMgnHWQdyZjO/giphy.gif">
    </a>
  </p>


[![ruby][ruby]][ruby-url] [![ror][ror]][ror-url] [![Postgres][Postgres]][Postgres-url] [![RSpec][RSpec]][RSpec-url] [![Atom][Atom]][Atom-url]


</div>

---

## Description

A rails backend API; Tea Subscription was built with test-driven development, with Rspec used for testing. It is built with Rails conventions over configuration as a guiding principle. A service-facade design pattern is used when calling external API services.

---

## <a name="contents"></a> Table of contents

- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Database setup](#database-setup)
  - [Required API keys](#required-keys)
- [Endpoints](#endpoints)
  - [Create Subscription](#create-sub)
  - [Cancel Subscription](#cancel-sub)
  - [Customer Subscriptions](#customer-subs)

---

## <a name="architecture"></a>Architecture

# <img src="app/assets/images/schema-diagram.png">

---
<p align="right">(<a href="#contents">back to top</a>)</p>

## <a name="prerequisites"></a>Prerequisites


Ruby:
  ```sh
  2.7.4
  ```
Rails:
  ```sh
  5.2.8
  ```
Database:
  ```sh
  postgresql@14
  ```
---
<p align="right">(<a href="#contents">back to top</a>)</p>


## <a name="database-setup"></a>Database Setup

Instructions to set up a local version of Tea Subscription:

Fork and clone the project, then install the required gems with `bundle`. A full list of gems that will be installed can be found in the [gemfile][gemfile-url].

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
<p align="right">(<a href="#contents">back to top</a>)</p>

## <a name="endpoints"></a>Endpoints

### <a name="create-sub"></a>Create Subscription

Creates a new customer subscription.

<br>

```
POST '/api/v1/subscriptions'
```

**Sample body**

 ```json
 {
    "title": "Customer's Herbal",
    "price": 15,
    "frequency": "monthly",
    "customer_id": {{customer_id}},
    "tea_id": {{tea_id}}
 }
 ```

**Sample response (status 200)**

 ```json
 {
     "data": {
         "id": "4",
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

 ```json
 {
     "title": "",
     "price": 15,
     "frequency": "monthly",
     "customer_id": {{customer_id}},
     "tea_id": {{tea_id}}
 }
 ```

**Sample response (status 422)**

 ```json
[
    "Title can't be blank"
]
 ```

---
<p align="right">(<a href="#contents">back to top</a>)</p>

### <a name="cancel-sub"></a>Cancel Subscription

Cancel a customer subscription.

<br>

```
PATCH "/api/v1/subscriptions/#{id}"
```

<br>

**Sample body**

 ```json
 {
     "status": 1
 }
 ```

**Sample response (status 200)**

 ```json
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

 ```json
 {
     "status": 2
 }
 ```

**Sample response (status 422)**

 ```json
 {
     "error": "'2' is not a valid status"
 }
 ```

---
<p align="right">(<a href="#contents">back to top</a>)</p>

### <a name="customer-subs"></a>Customer Subscriptions

Fetch all subscriptions belonging to a customer.

<br>

```
GET "/api/v1/customers/#{customer_id}/subscriptions"
```

**Sample response (status 200)**

 ```json
 {
     "data": [
         {
             "id": "1",
             "type": "subscription",
             "attributes": {
                 "title": "Magdalen Vandervort's Black",
                 "status": "active",
                 "price": 7,
                 "frequency": "quarterly",
                 "tea_id": 1,
                 "customer_id": 1
             }
         },
         {
             "id": "2",
             "type": "subscription",
             "attributes": {
                 "title": "Magdalen Vandervort's Green",
                 "status": "active",
                 "price": 14,
                 "frequency": "one_time",
                 "tea_id": 2,
                 "customer_id": 1
             }
         },
         {
             "id": "3",
             "type": "subscription",
             "attributes": {
                 "title": "Magdalen Vandervort's Green",
                 "status": "active",
                 "price": 10,
                 "frequency": "weekly",
                 "tea_id": 3,
                 "customer_id": 1
             }
         }
     ]
 }
 ```

**Sample response (status 404)**

 ```json
 {
    "error": "Couldn't find Customer with 'id'=4168498141546"
 }
 ```

---
<p align="right">(<a href="#contents">back to top</a>)</p>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][LinkedIn]][LinkedIn-url]


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/AMSterling/tea_subscription.svg?style=for-the-badge
[contributors-url]: https://github.com/AMSterling/tea_subscription/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/AMSterling/tea_subscription.svg?style=for-the-badge
[forks-url]: https://github.com/AMSterling/tea_subscription/network/members
[gemfile-url]: https://github.com/AMSterling/tea_subscription/blob/main/Gemfile
[stars-shield]: https://img.shields.io/github/stars/AMSterling/tea_subscription.svg?style=for-the-badge
[stars-url]: https://github.com/AMSterling/tea_subscription/stargazers
[issues-shield]: https://img.shields.io/github/issues/AMSterling/tea_subscription.svg?style=for-the-badge
[issues-url]: https://github.com/AMSterling/tea_subscription/issues
[license-shield]: https://img.shields.io/github/license/AMSterling/tea_subscription.svg?style=for-the-badge
[license-url]: https://github.com/AMSterling/tea_subscription/blob/master/LICENSE.txt
[LinkedIn]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[LinkedIn-url]: https://linkedin.com/in/sterling-316a6223a/

[Atom]: https://custom-icon-badges.demolab.com/badge/Atom-5FB57D?style=for-the-badge&logo=atom
[Atom-url]: https://github.com/atom/atom/releases/tag/v1.60.0

[Bootstrap]: https://img.shields.io/badge/bootstrap-%23563D7C.svg?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com/

[Capybara]: https://custom-icon-badges.demolab.com/badge/Capybara-F7F4EF?style=for-the-badge&logo=capybara
[Capybara-url]: https://www.patreon.com/capybara

[CircleCI]: https://img.shields.io/badge/circle%20ci-%23161616.svg?style=for-the-badge&logo=circleci&logoColor=white
[CircleCI-url]: https://circleci.com/developer

[CSS]: https://img.shields.io/badge/CSS-239120?&style=for-the-badge&logo=css3&logoColor=white
[CSS-url]: https://en.wikipedia.org/wiki/CSS

[Fly]: https://custom-icon-badges.demolab.com/badge/Fly-DCDCDC?style=for-the-badge&logo=fly-io
[Fly-url]: https://fly.io/

[Git Badge]: https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white
[Git-url]: https://git-scm.com/

[GitHub Badge]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white
[GitHub-url]: https://github.com/enter_url/

[GitHub Actions]: https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white
[GitHub Actions-url]: https://github.com/features/actions

[GraphQL]: https://img.shields.io/badge/-GraphQL-E10098?style=for-the-badge&logo=graphql&logoColor=white
[GraphQL-url]: https://graphql.org/

[Heroku]: https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white
[Heroku-url]: https://www.heroku.com/

[Homebrew]: https://custom-icon-badges.demolab.com/badge/Homebrew-2e2a24?style=for-the-badge&logo=homebrew_logo
[Homebrew-url]: https://brew.sh/

[HTML5]: https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white
[HTML5-url]: https://en.wikipedia.org/wiki/HTML5

[JavaScript]: https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E
[JavaScript-url]: https://www.javascript.com/

[jQuery]: https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white
[jQuery-url]: https://github.com/rails/jquery-rails

[LinkedIn Badge]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[LinkedIn-url]: https://www.linkedin.com/in/enter_url/

[MacOS]: https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0
[MacOS-url]: https://www.apple.com/macos

[Miro]: https://img.shields.io/badge/Miro-050038?style=for-the-badge&logo=Miro&logoColor=white
[Miro-url]: https://miro.com/

[Postgres]: https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/

[PostgreSQL]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[PostgreSQL-url]: https://www.postgresql.org/

[Postman]: https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white
[Postman-url]: https://web.postman.co/

[Rails]: https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/

[Redis]: https://img.shields.io/badge/redis-%23DD0031.svg?&style=for-the-badge&logo=redis&logoColor=white
[Redis-url]: https://redis.io/

[Replit]: https://img.shields.io/badge/replit-667881?style=for-the-badge&logo=replit&logoColor=white
[Replit-url]: https://replit.com/

[ror]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[ror-url]: https://rubyonrails.org/

[RSpec]: https://custom-icon-badges.demolab.com/badge/RSpec-fffcf7?style=for-the-badge&logo=rspec
[RSpec-url]: https://rspec.info/

[RuboCop]: https://img.shields.io/badge/RuboCop-000?logo=rubocop&logoColor=fff&style=for-the-badge
[RuboCop-url]: https://docs.rubocop.org/rubocop-rails/index.html

[Ruby]: https://img.shields.io/badge/Ruby-000000?style=for-the-badge&logo=ruby&logoColor=CC342D
[Ruby-url]: https://www.ruby-lang.org/en/

[Slack]: https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white
[Slack-url]: https://slack.com/trials?remote_promo=f4d95f0b&utm_medium=ppc&utm_source=google&utm_campaign=ppc_google_amer_en_brand_selfserve_discount&utm_term=Slack_Exact_._slack_._e_._c&utm_content=611662283461&gclid=Cj0KCQiA54KfBhCKARIsAJzSrdptOf7OUrgfeH0CWCC7LaOjR8arXoBnBMZjUSTJqmzTKvH6Jh-YXzAaAjfWEALw_wcB&gclsrc=aw.ds

[Tailwind]: https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=for-the-badge&logo=tailwind-css&logoColor=white
[Tailwind-url]: https://tailwindcss.com/

[Visual Studio Code]: https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white
[Visual Studio Code-url]: https://code.visualstudio.com/

[XCode]: https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white
[XCode-url]: https://developer.apple.com/xcode/

[Zoom]: https://img.shields.io/badge/Zoom-2D8CFF?style=for-the-badge&logo=zoom&logoColor=white
[Zoom-url]: https://zoom.us/

[bcrypt-docs]: https://github.com/bcrypt-ruby/bcrypt-ruby
[capybara-docs]: https://github.com/teamcapybara/capybara
[factory_bot_rails-docs]: https://github.com/thoughtbot/factory_bot_rails
[faker-docs]: https://github.com/faker-ruby/faker
[faraday-docs]: https://lostisland.github.io/faraday/
[figaro-docs]: https://github.com/laserlemon/figaro
[jsonapi-serializer-docs]: https://github.com/jsonapi-serializer/jsonapi-serializer
[launchy-docs]: https://www.rubydoc.info/gems/launchy/2.2.0
[omniauth-google-oauth2-docs]: https://github.com/zquestz/omniauth-google-oauth2
[orderly-docs]: https://github.com/jmondo/orderly
[pry-docs]: https://github.com/pry/pry
[rspec-rails-docs]: https://github.com/rspec/rspec-rails
[shoulda-matchers-docs]: https://github.com/thoughtbot/shoulda-matchers
[simplecov-docs]: https://github.com/simplecov-ruby/simplecov
[vcr-docs]: https://github.com/vcr/vcr
[webmock-docs]: https://github.com/bblimke/webmock
