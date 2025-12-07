# iCafe Backend

A comprehensive Spring Boot-based backend application for an online coffee shop management system (iCafe). This project provides REST APIs and web interfaces for managing products, orders, user accounts, and reporting.

## 🎯 Overview

iCafe Backend is a full-featured e-commerce platform tailored for coffee shops, built with modern Spring Boot 3.x architecture. The application enables customers to browse products, place orders, and manage their accounts, while providing administrators with tools for inventory management, order processing, and business reporting.

## 🛠️ Technology Stack

### Core Framework
- **Java 17** - Programming language
- **Spring Boot 3.4.3** - Application framework
- **Spring Data JPA** - ORM and database access
- **MySQL 8.0** - Relational database

### Additional Technologies
- **Spring Security** - Authentication and authorization
- **Spring Validation** - Input validation
- **Spring Web** - REST API and web MVC
- **JSP** - Server-side web templating
- **Maven** - Build and dependency management

### Database
- **MySQL 8.0** - Primary data store
- **Hibernate** - JPA implementation with MySQL8Dialect

## 📋 Prerequisites

Before running this project, ensure you have the following installed:

- **Java Development Kit (JDK)** 17 or higher
- **Maven** 3.6+ (included via `mvnw`)
- **MySQL** 8.0 or higher
- **Git** (for version control)

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone <repository-url>
cd iCafeBackend/demo
```

### 2. Configure Database

Create a MySQL database for the application:
```sql
CREATE DATABASE icafe_db;
```

Update the database connection in `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/icafe_db?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=your_password
```

### 3. Initialize Database

The application uses Hibernate with `ddl-auto=update`, which will automatically create and update tables. Optionally, you can run the initialization scripts:
- `initdb.sql` - Database schema initialization
- `src/main/resources/icafe.sql` - Sample data

### 4. Build the Application

Using Maven wrapper (no need to install Maven separately):
```bash
# On Windows
mvnw.cmd clean package

# On macOS/Linux
./mvnw clean package
```

Or with installed Maven:
```bash
mvn clean package
```

### 5. Run the Application

```bash
# Option 1: Using Maven
mvn spring-boot:run

# Option 2: Using Java
java -jar target/demo-0.0.1-SNAPSHOT.war
```

The application will start on `http://localhost:8080` by default.

## 📁 Project Structure

```
demo/
├── src/
│   ├── main/
│   │   ├── java/com/icafe/demo/
│   │   │   ├── DemoApplication.java          # Main Spring Boot application class
│   │   │   ├── config/                       # Configuration classes
│   │   │   ├── controller/                   # REST controllers and request handlers
│   │   │   ├── dto/                          # Data Transfer Objects
│   │   │   ├── entity/                       # JPA entity classes
│   │   │   ├── enums/                        # Enumeration classes
│   │   │   ├── mapper/                       # Entity-DTO mappers
│   │   │   ├── models/                       # Domain models
│   │   │   ├── repository/                   # Data access layer (Spring Data JPA)
│   │   │   ├── security/                     # Security configurations and components
│   │   │   ├── service/                      # Business logic layer
│   │   │   └── specification/                # JPA specifications for dynamic queries
│   │   ├── resources/
│   │   │   ├── application.properties        # Application configuration
│   │   │   ├── application.yml               # YAML configuration (alternative)
│   │   │   ├── icafe.sql                     # Database initialization script
│   │   │   ├── static/                       # Static resources (CSS, JS, images)
│   │   │   └── webapp/
│   │   │       ├── WEB-INF/
│   │   │       │   ├── views/                # JSP templates
│   │   │       │   ├── web.xml               # Servlet configuration
│   │   │       │   └── beans.xml             # Bean definitions
│   │   │       ├── css/                      # Stylesheets
│   │   │       ├── js/                       # JavaScript files
│   │   │       └── imgs/                     # Image resources
│   ├── test/
│   │   └── java/com/icafe/demo/              # Unit and integration tests
├── target/                                   # Build output directory
├── upload/                                   # Runtime upload directory for images
├── pom.xml                                   # Maven project configuration
├── mvnw / mvnw.cmd                           # Maven wrapper scripts
└── README.md                                 # This file
```

## 🔧 Configuration

### Key Application Properties

| Property | Description | Default |
|----------|-------------|---------|
| `spring.datasource.url` | MySQL database URL | `jdbc:mysql://localhost:3306/icafe_db` |
| `spring.datasource.username` | Database username | `root` |
| `spring.datasource.password` | Database password | `123456` |
| `spring.jpa.hibernate.ddl-auto` | Hibernate DDL strategy | `update` |
| `spring.servlet.multipart.max-file-size` | Max upload file size | `10MB` |
| `spring.web.cors.allowed-origins` | CORS allowed origins | `*` |
| `server.port` | Server port | `8080` |

### CORS Configuration

The application allows CORS requests from all origins with the following methods and headers:
- **Allowed Methods**: GET, POST, PUT, DELETE, OPTIONS
- **Allowed Headers**: All headers accepted
- **Allowed Origins**: All origins (*)

## 📝 Main Features

### User Management
- User registration and login
- Account management and profile updates
- Password recovery (forgot password)
- Role-based access control (RBAC)

### Product Management
- Product catalog with categories
- Product search and filtering
- Product details and specifications

### Order Management
- Shopping cart functionality
- Order placement and confirmation
- Order status tracking
- Order history

### Admin Features
- Product inventory management
- Order processing and fulfillment
- Sales reporting and analytics
- User account administration

### File Upload
- Support for product images and user avatars
- File upload directory: `upload/images/`
- Maximum file size: 10MB

## 🌐 API Endpoints

The application provides REST APIs for:

- **Authentication**: Login, registration, password recovery
- **Products**: CRUD operations, search, filtering
- **Orders**: Create, retrieve, update, cancel orders
- **Users**: Profile management, account updates
- **Categories**: Product category management
- **Reports**: Sales and analytics reporting

## 🔐 Security

- Spring Security integration for authentication and authorization
- JWT token support (if configured)
- CORS protection
- Input validation using Spring Validation
- SQL injection prevention through parameterized queries (JPA)

## 📊 Database Schema

The application manages the following primary entities:

- **Users** - User accounts and profiles
- **Products** - Product catalog
- **Categories** - Product categories
- **Orders** - Customer orders
- **OrderItems** - Individual items in orders
- **Roles** - User roles for RBAC

Auto-created on first run with Hibernate DDL-auto set to `update`.

## 🧪 Testing

Run tests using Maven:

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=YourTestClass

# Run with coverage
mvn clean test jacoco:report
```

Test files are located in `src/test/java/com/icafe/demo/`.

## 📦 Building for Production

Create an optimized WAR file:

```bash
mvn clean package -DskipTests -Pprod
```

The compiled WAR file will be available at `target/demo-0.0.1-SNAPSHOT.war`.

## 🐛 Troubleshooting

### Database Connection Issues
- Ensure MySQL is running on `localhost:3306`
- Verify database name, username, and password in `application.properties`
- Check MySQL driver compatibility with Java 17

### Port Already in Use
- Change the port in `application.properties`: `server.port=8081`
- Or kill the process using port 8080

### Build Failures
- Clear Maven cache: `mvn clean`
- Ensure JDK 17 is being used: `java -version`
- Update Maven: `mvn -U clean package`

## 📚 Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Data JPA](https://spring.io/projects/spring-data-jpa)
- [Spring Security](https://spring.io/projects/spring-security)
- [MySQL Documentation](https://dev.mysql.com/doc/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is part of the PTIT coursework for "Introduction to Software Technology".

## 👥 Authors

- PTIT Students - iCafe Team

## 📞 Support

For issues, questions, or contributions, please open an issue on the repository or contact the development team.

---

**Last Updated**: December 2025  
**Version**: 0.0.1-SNAPSHOT
