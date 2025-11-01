CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE,
    password VARCHAR(50) NOT NULL
);

-- We can run this code in CLI terminal by using source <filename>.sql command.