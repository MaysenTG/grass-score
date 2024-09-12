# Grass Score

## Description

Grass score is a fullstack Ruby on Rails app for easy scoring of the card game Grass

## Prerequisites

- Docker
- Ruby 3.3.2

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/MaysenTG/grass-score.git
   cd myapp
   ```

## Usage

1. Build and run the application using Docker Compose:
   ```sh
   docker compose up
   ```
2. The application should now be running and accessible at `http://localhost:3000`.

## Running Tests

1. To run the tests, use the following command:
   ```sh
   rails db:create db:schema:load && rspec
   ```
