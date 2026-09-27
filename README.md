# HVPC Tech - Laptop Shopping Project

HVPC Tech is a laptop shopping web application built with
Spring Boot and Spring MVC.

The project demonstrates a traditional server-side rendered
Java web application using JSP, Spring Data JPA,
Spring Security and MySQL.

---

## Tech Stack

- Java 17
- Spring Boot
- Spring MVC
- Spring Data JPA
- Spring Security
- Hibernate
- JSP / JSTL
- MySQL
- Bootstrap
- Maven

---

## Architecture

The project follows a layered architecture:

```text
Browser
   ↓
Controller
   ↓
Service
   ↓
Repository
   ↓
MySQL
```

For server-side rendering:

```text
Browser
   ↓
Spring MVC Controller
   ↓
Model
   ↓
JSP
   ↓
HTML Response
```

---

## Main Features

### Authentication

- User registration
- Login
- Logout
- BCrypt password hashing
- Spring Security
- CSRF protection
- USER / ADMIN role authorization

### Product Management

- View products
- Create products
- Update products
- Delete products
- Upload product images
- Product detail page
- Manufacturer filtering
- Price filtering
- Quantity filtering
- Sorting
- Pagination

### Shopping Cart

- Session-based shopping cart
- Add product
- Increase quantity
- Decrease quantity
- Remove product
- Calculate total price

### Checkout

- Create order
- Create order details
- Store historical product price
- Update product stock
- Clear cart after successful checkout

### Order Management

- User order history
- Admin order management
- Order detail page
- Order status management
- Delete order

### User Profile

- View profile
- Update profile
- Upload avatar
- Delete avatar

### Admin

- Admin dashboard
- Product management
- User management
- Order management

---

## Project Structure

```text
src/main/java/vn/mershker/spring/HoangVuPCBasic
├── config
├── controller
├── domain
├── dto
├── repository
├── service
└── specification
```

JSP views:

```text
src/main/webapp/WEB-INF/view
├── admin
├── auth
├── client
└── shared
```

---

## Database

The project uses MySQL.

Create a database before running the project:

```sql
CREATE DATABASE hoangvupc_basic;
```

---

## Configuration

The real `application.properties` file is intentionally
excluded from Git because it may contain local database
credentials.

Copy:

```text
src/main/resources/application-example.properties
```

to:

```text
src/main/resources/application.properties
```

Then configure your own MySQL information:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/hoangvupc_basic
spring.datasource.username=root
spring.datasource.password=your_password
```

Configure an optional administrator account:

```properties
app.admin.email=admin@example.com
app.admin.password=your_admin_password
```

---

## Run The Project

Using Maven Wrapper on Windows:

```bash
mvnw.cmd spring-boot:run
```

Linux / macOS:

```bash
./mvnw spring-boot:run
```

Then open:

```text
http://localhost:8080
```

---

## Security Notes

Sensitive local files are excluded from Git:

```text
application.properties
uploads/
.idea/
target/
```

Do not commit database passwords, administrator passwords,
API keys, tokens or other credentials.

---

## Future Improvements

Possible improvements:

- React / TypeScript frontend
- REST API
- JWT authentication
- Redis shopping cart
- Online payment integration
- Docker
- Automated testing
- Cloud image storage
- CI/CD