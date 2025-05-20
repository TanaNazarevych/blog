# 📝 Blog of Vito

A full-stack Ruby on Rails blog platform built as part of my **software engineering internship at Sentia Australia**.  
Blog of Vito supports user authentication, image uploads, nested comments, and a clean content-driven UI — ideal for portfolio showcasing and editorial use cases.

---

## 🌟 Features

-  Devise authentication (user login, registration, email confirmation)
-  Articles with rich content and optional images
-  Nested commenting system (one level deep)
-  Image upload via CarrierWave
-  Admin support for managing articles
-  Slim templating and responsive layout
-  Test coverage using built-in Rails test framework

---

## 🛠 Tech Stack

| Tool           | Description                                  |
|----------------|----------------------------------------------|
| Ruby 3.1.2      | Language used for backend logic              |
| Rails 7.x       | MVC framework powering the app               |
| Devise          | Authentication and user management           |
| CarrierWave     | Image uploader for articles                  |
| SQLite3         | Default local database                       |
| Slim            | Lightweight view templating                  |
| Bootstrap       | Styling and responsive layout                |

---

## 🚀 Getting Started (Local Setup)

> **Ruby 3.1.2 is required** to run this project. You can install it via `rvm` or `rbenv`.

### 1. Clone the repo

```bash
git clone https://github.com/TanaNazarevych/blog.git
cd blog

### 2. Install dependencies
bundle install
yarn install # if using Rails 7 with Webpacker or jsbundling-rails


### 3. Set up the database
rails db:create
rails db:migrate
rails db:seed #  seeds were provided by Sentia Austalia


### 4. Run the server
rails server
Then go to http://localhost:3000 in your browser



