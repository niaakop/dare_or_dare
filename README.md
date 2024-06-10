# Dare or Dare

"Dare or Dare" is a Rails application designed to manage and play a dare game. Players can create, update, and manage games and dares.

## Requirements

- Ruby 3.0.0
- Rails 7.1.3
- SQLite3

## Installation

1. Clone the repository:
   `git clone https://github.com/niaakop/dare_or_dare.git`
   `cd dare_or_dare`

2. Install dependencies:
   `bundle install`

3. Set up the database:
   `rails db:create`
   `rails db:migrate`
   `rails db:seed`

## Usage

1. Start the Rails server:
   `rails server`

2. Open your web browser and go to `http://localhost:3000`.

## Configuration

Ensure you have the necessary environment variables set up. You can use a `.env` file to manage these settings.

## Testing

Run the test suite with:
`rails test`

## Deployment

For deployment, ensure you have configured your environment properly and run:
`rails db:migrate RAILS_ENV=production`
`rails assets:precompile`

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a Pull Request.

## License

This project is licensed under the MIT License.
