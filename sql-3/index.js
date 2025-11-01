/*
  SQL with Node.js & Routing (CRUD Operations)

  This script demonstrates how to build a simple web application that interacts with a MySQL database using Node.js.
  It covers the core CRUD (Create, Read, Update, Delete) operations, and uses the following technologies:
    - MySQL2: Node.js library to connect and interact with a MySQL database.
    - Express: Web framework for handling HTTP requests and routing.
    - EJS: Templating engine for rendering dynamic HTML pages.
    - Faker: Library for generating random fake user data (for demonstration purposes).
    - method-override: Allows using HTTP verbs such as PUT and DELETE in places where the client doesn't support it.

  Key Concepts Demonstrated:
    1. **Database Connection:** Shows how to connect to a MySQL database from Node.js.
    2. **Batch Insertion:** Uses Faker to generate 100 fake users and batch insert them into a 'users' table.
    3. **CRUD Routes:**
        - Create: Add new users via a form and insert into the database.
        - Read: Display all users and show user counts.
        - Update: Edit existing users (with password verification) and update their information.
        - Delete: Remove users from the database after confirmation.
    4. **Templating with EJS:** Renders dynamic pages for listing, editing, creating, and deleting users.
    5. **Beginner-Friendly Practices:** Uses clear comments and simple error handling to help newcomers understand each step.

  How this code works:
    - When started, it connects to your MySQL database and inserts 100 fake users for testing.
    - The Express server provides web routes for viewing, editing, adding, and deleting users.
    - It uses EJS templates to render HTML forms and lists.
    - All SQL queries are written as plain strings and executed with parameterized queries to prevent SQL injection.
    - You can view and manipulate the users through a web browser, practicing real-world SQL operations from Node.js.

  This is a great starting point for beginners learning how to:
    - Build full-stack applications with Node.js and SQL databases.
    - Understand how web forms interact with backend servers and databases.
    - Safely perform CRUD operations and render results in the browser.
*/

const { faker } = require('@faker-js/faker');
const mysql = require('mysql2');
const express = require("express");
const app = express();
const port = 8080;
const path = require("path");
const methodOverride = require("method-override");
const { v4: uuidv4 } = require('uuid');

// Middleware to support HTTP verbs such as PUT or DELETE in places where the client doesn't support it.
// This allows us to override methods in forms by using a query parameter like ?_method=DELETE
app.use(methodOverride("_method"));

// Middleware to parse incoming request bodies with urlencoded payloads (typically from form submissions)
app.use(express.urlencoded({ extended: true }));

// Set EJS as the templating engine for rendering views
app.set("view engine", "ejs");

// Define the directory where the view templates are stored
app.set("views", path.join(__dirname, "/views"));

// Function to generate a single random user with id, username, email, and password
function getRandomUser() {
  return [
    faker.string.uuid(),           // Generate a unique UUID for user ID
    faker.internet.username(),     // Generate a random username
    faker.internet.email(),        // Generate a random email address
    faker.internet.password(),     // Generate a random password
  ];
}

// Create a connection to the MySQL database
const connection = mysql.createConnection({
  host: 'localhost',     // Database host
  user: 'root',          // Database username
  password: 'mysql@123', // Database password
  database: 'app'        // Database name
});

// SQL query to insert multiple rows into the 'users' table
// The VALUES ? syntax allows bulk insertion using an array of arrays
let q = "INSERT INTO users (id, username, email, password) VALUES ?";

// Prepare an array to hold multiple fake users
let data = [];
for (let i = 0; i < 100; i++) {
  data.push(getRandomUser());  // Generate and add 100 random users to the data array
}

// Execute the query to insert all generated users into the database
// Note: We do NOT close the connection here because we need it for the Express routes below.
// The connection will remain open for the lifetime of the application.
try {
  connection.query(q, [data], (err, result) => {
    if (err) {
      console.log(err);    // Log any errors during insertion
      // Don't close connection here - we need it for the routes below
      return;
    }
    console.log(result);   // Log the result of the insertion (e.g., affected rows)
    // Connection remains open for use by Express routes
  });
} catch (err) {
  console.log(err);        // Catch and log any unexpected errors
  // Connection remains open even on error to allow routes to function
}

/*
Note:
After running this script, you can use the MySQL CLI to view the inserted data.
For example:
1. Open MySQL CLI: `/usr/local/mysql/bin/mysql -u root -p`
2. Select the database: `USE app;`
3. View all users: `SELECT * FROM users;`
This allows you to verify that the data has been inserted correctly.
*/

// Home Route
// This route handles GET requests to the root URL "/".
// It queries the database to count the total number of users and renders the "home.ejs" template with this count.
app.get("/", (req, res) => {
  let q = "SELECT count(*) FROM users"; // SQL query to count all users
  try {
    connection.query(q, (err, result) => {
      if (err) {
        console.log(err);              // Log any database errors
        return res.send("Some Error in DB"); // Send error response to client
      }
      let count = result[0]["count(*)"]; // Extract the count from the result
      res.render("home.ejs", { count }); // Render the home page with user count
    });
  } catch (err) {
    console.log(err);               // Log unexpected errors
    res.send("Unexpected Error");  // Send generic error response
  }
});

// Show Route
// This route handles GET requests to "/user".
// It retrieves all user records from the database and renders them in the "users.ejs" template.
app.get("/user", (req, res) => {
  let q = "SELECT * FROM users"; // SQL query to select all users
  try {
    connection.query(q, (err, result) => {
      if (err) {
        console.log(err);            // Log any errors from the database
        res.send("Some error in DB"); // Inform client of the error
      }
      console.log(result);           // Log the retrieved users (for debugging)
      res.render("users.ejs", { result }); // Render the users page with the data
    })
  } catch (err) {
    console.log(`Unexpected Error ${err}`); // Log unexpected errors
  }
});

// Edit Route
// This route handles GET requests to "/user/:id/edit".
// It fetches the user with the specified ID and renders the "edit.ejs" form to allow editing.
app.get("/user/:id/edit", (req, res) => {
  let { id } = req.params; // Extract user ID from URL parameters
  let q = "SELECT * FROM users WHERE id = ?"; // SQL query to get user by ID (using parameterized query to prevent SQL injection)
  try {
    connection.query(q, [id], (err, result) => {
      if (err) {
        console.log(err); // Log any errors
        return;
      }
      let user = result[0]; // Get the first (and only) user from the result
      res.render("edit.ejs", { user }); // Render the edit form with user data
    })
  } catch (err) {
    console.log(`Error: ${err}`) // Log unexpected errors
  }
});

// Update Route
// This route handles PATCH requests to "/user/:id".
// It verifies the user's current password before updating the username in the database.
app.patch("/user/:id", (req, res) => {
  let { id } = req.params; // Get user ID from URL
  let { password: formPass, username: newUsername } = req.body; // Extract password and new username from form data

  let q1 = "SELECT * FROM users WHERE id = ?"; // Query to fetch user by ID
  connection.query(q1, [id], (err, result) => {
    if (err) {
      console.log(err);           // Log DB errors
      return res.send("Database error"); // Send error response
    }

    let user = result[0];        // Get the user record
    if (!user) return res.send("User not found"); // Handle case where user doesn't exist

    // Check if the password provided matches the stored password
    if (formPass !== user.password) {
      return res.send("WRONG password"); // Reject update if password is incorrect
    }

    // If password matches, update the username
    let q2 = "UPDATE users SET username = ? WHERE id = ?";
    connection.query(q2, [newUsername, id], (err, result) => {
      if (err) {
        console.log(err);               // Log update errors
        return res.send("Error updating username"); // Inform client of error
      }
      res.redirect("/user");            // Redirect to the users list after successful update
    });
  });
});

// New User Form Route
// This route handles GET requests to "/user/new".
// It renders a form for creating a new user.
app.get("/user/new", (req, res) => {
  res.render("new.ejs"); // Render the new user form
});

// Create User Route
// This route handles POST requests to "/user" for creating a new user.
// It inserts the new user's data into the database with a generated UUID.
app.post("/user", (req, res) => {
  let { username, email, password } = req.body; // Extract user data from form submission
  let q = "INSERT INTO users (id, username, email, password) VALUES (?, ?, ?, ?)"
  try {
    connection.query(q, [uuidv4(), username, email, password], (err, result) => {
      if (err) {
        console.log(err);              // Log insertion errors
        res.send("Error adding user to DB"); // Inform client of error
        return;
      }
      res.redirect("/user");           // Redirect to users list after successful insertion
    });
  } catch (err) {
    console.log(err);                  // Log unexpected errors
  }
});

// Delete Confirmation Route
// This route handles GET requests to "/user/:id/delete".
// It fetches the user data and renders a confirmation page before deletion.
app.get("/user/:id/delete", (req, res) => {
  let { id } = req.params;           // Get user ID from URL
  let q = "SELECT * FROM users WHERE id = ?" // Query to select user by ID
  try {
    connection.query(q, [id], (err, result) => {
      if (err) {
        console.log(`Unexpected Error: ${err}`); // Log errors
        return;
      }
      let user = result[0];          // Get user data
      res.render("delete.ejs", { user }); // Render delete confirmation page
    });
  } catch (err) {
    console.log(err);                // Log unexpected errors
  }
})

// Delete User Route
// This route handles DELETE requests to "/user/:id".
// It verifies the user's password before deleting the user from the database.
app.delete("/user/:id", (req, res) => {
  let { id } = req.params;           // Extract user ID from URL
  let { password: formPass } = req.body; // Extract password from form data
  
  let q1 = "SELECT * FROM users WHERE id = ?"; // Query to fetch user by ID
  connection.query(q1, [id], (err, result) => {
    if (err) {
      console.log(err);           // Log DB errors
      return res.send("Database error"); // Send error response
    }

    let user = result[0];        // Get the user record
    if (!user) return res.send("User not found"); // Handle case where user doesn't exist

    // Check if the password provided matches the stored password
    if (formPass !== user.password) {
      return res.send("WRONG password"); // Reject deletion if password is incorrect
    }

    // If password matches, delete the user
    let q2 = "DELETE FROM users WHERE id = ?"; // SQL query to delete user by ID
    connection.query(q2, [id], (err, result) => {
      if (err) {
        console.log(`Delete Error: ${err}`); // Log errors during deletion
        return res.send("Error deleting user"); // Send error response
      }
      res.redirect("/user");          // Redirect to users list after deletion
    });
  });
});

// Start the Express server and listen on the specified port
app.listen(port, () => {
  console.log(`listening at port ${port}`); // Log message indicating server is running
});