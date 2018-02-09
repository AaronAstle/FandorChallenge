# Fandor Coding Challenge
---
Ruby on Rails API for viewing film details and ratings.  Users can log in to
create a film or to rate a film.


## Requirements
---
  - Ruby >= 2.3.1
  - Rails ~> 5.1.4
  - [HTTPie](https://httpie.org/) or [Postman](https://www.getpostman.com/) for
  HTTP Requests.  Personally used Postman as it has a great interface.  But if
  you prefer CLI then HTTPie is great.

The database used was kept to `SQLite` for sample purposes of this challenge.

## Getting up and running
---

Clone this repo then follow the steps below.  

1. Install dependencies and mitigate any errors that may arise.

  `$ bundle install`

2. Create the database for the app.

  `$ rails db:migrate`  

3. Seed Sample Data for viewing and interacting. This utilizes Faker and FactoryBot
to create sample data.

  `$ rails db:seed`

4. Start the Rails Server.

  `$ rails s`

5. Interacting will be done through the API and HTTP Requests.  THis is where
`HTTPie` or `Postman` will be your interface with the API.  Below is the list
routes that you can interact with.

    ```
           films GET    /films(.:format)                      films#index
                 POST   /films(.:format)                      films#create
            film GET    /films/:id(.:format)                  films#show
                 PATCH  /films/:id(.:format)                  films#update
                 PUT    /films/:id(.:format)                  films#update
                 DELETE /films/:id(.:format)                  films#destroy
    film_ratings GET    /films/:film_id/ratings(.:format)     ratings#index
                 POST   /films/:film_id/ratings(.:format)     ratings#create
     film_rating GET    /films/:film_id/ratings/:id(.:format) ratings#show
                 PATCH  /films/:film_id/ratings/:id(.:format) ratings#update
                 PUT    /films/:film_id/ratings/:id(.:format) ratings#update
                 DELETE /films/:film_id/ratings/:id(.:format) ratings#destroy
      auth_login POST   /auth/login(.:format)                 authentication#authenticate
          signup POST   /signup(.:format)                     users#create
    ```

## Interaction Params
---

#### POST/PUT Films - Requires Auth Token Provided at signup. So save it and use it.

  - **Title** _string_
  - **Description** _text_
  - **Year** _string_

#### POST/PUT Ratings - Requires Auth Token

  - **rating_value** _integer_ between 1 and 5
  - **comment** _text_ (optional)


## Sample Film and Rating Creation
---

```bash
  # Using HTTPie for the samples.

  $ http :3000/films  # GET JSON data of first 10 films, will paginate

  $ http :3000/films page==2  # GET next page of films

  $ http POST :3000/films title=Dracula description="A movie about a vampire" year=1992 \
    'Authorization':'{YOUR_AUTH_TOKEN}'  # Create New Film

  $ http POST :3000/films/1/ratings rating_value=3 comment="Too much blood" \
    'Authorization':'{YOUR_AUTH_TOKEN}'  # Create New Rating for Film id = 1

```


## Testing

The test suite was built with the use a few helping libraries.  Specs have
been written for alomst all of the API.  The following steps will help
you to run the test suite.

- `$ bundle install`
- `$ rails db:migrate RAILS_ENV=test`
- `$ bundle exec rspec`


## Notes

Thank you for the opportunity to share my skill in this challenge.  I look
forward to dicussing the challenge.

-Aaron Astle
