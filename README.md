# Salad Todo

## Getting started

To get started, just clone this repo. Make sure you have a running PostgreSQL
instance and adjust the database credentials in app/config/server/config.coffee

Then execute:

    git clone https://github.com/komola/salad-todo.git
    cd salad-todo
    npm install
    bower install
    grunt
    cake db:migrations:migrate

enter the directory, and execute `grunt server`. This will start a development server
on `http://localhost:3000`.

To build and minify the assets, execute `grunt build`. This will create the `public/assets/`
folder where it places the compiled and minified files.
