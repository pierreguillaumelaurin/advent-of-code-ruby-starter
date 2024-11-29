# Advent of Code Ruby Starter (Not functional yet. Still a work in progress.)
## Fetching a problem

```bash
ruby aoc day 1
```

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Set your Advent of Code session token:
   ```bash
   # In the project root
   bin/aoc config set-token YOUR_SESSION_TOKEN
   ```

## Running Solutions

### Using the CLI
```bash
# Run current year's day 1 solution
bin/aoc solve 1

# Specify a different year
bin/aoc solve --year 2023 1
```

### Using Rake
```bash
# Run a specific day's solution
rake aoc:solve[2024,1]
```

## Testing

Run tests and linters:
```bash
bundle exec rake
```

## Configuration

Configure in an initializer or before running solutions:

```ruby
AdventOfCode.configure do |config|
  config.default_year = 2024
  config.cache_dir = '/path/to/cache'
end
```

## Writing Solutions

1. Create a file in `lib/advent_of_code/solutions/year_2024/day_01.rb`
2. Implement `part_1` and `part_2` class methods
3. Inherit from `AdventOfCode::Solution`

Example:
```ruby
module Year2024
  module Day01
    def self.part_1(input)
      # Your solution here
    end

    def self.part_2(input)
      # Your solution here
    end
  end
end
```
