# Grass Score

## Description

Grass score is a fullstack Ruby on Rails app for easy scoring of the card game Grass

## Prerequisites

- **Ruby 3.3.2** (for local development)
- **PostgreSQL** (for local development)
- **Docker & Docker Compose** (for containerized setup)
- **Bundler** (Ruby dependency manager)

## Installation

### Option 1: Quick Setup (Recommended)

1. Clone the repository:
   ```sh
   git clone https://github.com/MaysenTG/grass-score.git
   cd grass-score
   ```

2. Run the automated setup script:
   ```sh
   chmod +x scripts/setup.sh
   ./scripts/setup.sh
   ```

   This script will:
   - Check for Ruby version managers (asdf, rbenv, rvm)
   - Install or switch to Ruby 3.3.2 if a version manager is found
   - Install dependencies via `bundle install`
   - Create and configure the PostgreSQL database
   - Load the database schema

### Option 2: Manual Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/MaysenTG/grass-score.git
   cd grass-score
   ```

2. Install Ruby 3.3.2 (if not already installed):
   - Using **rbenv**: `rbenv install 3.3.2 && rbenv local 3.3.2`
   - Using **rvm**: `rvm install 3.3.2 && rvm use 3.3.2`
   - Or download from [ruby-lang.org](https://www.ruby-lang.org/en/downloads/)

3. Install dependencies:
   ```sh
   bundle install
   ```

4. Set up the database:
   ```sh
   rails db:setup
   ```

## Development

### Running the Application Locally

```sh
bundle exec rails s
```

The application will be accessible at `http://localhost:3000`.

### Running with Docker

Build and run the application using Docker Compose:
```sh
docker compose up
```

The application will be accessible at `http://localhost:3000`.

## Testing

Run the test suite:
```sh
bundle exec rspec
```

To run tests with the database setup:
```sh
rails db:create db:schema:load && rspec
```

### Running Tests in Docker

```sh
docker compose run web rspec
```
