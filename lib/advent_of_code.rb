# frozen_string_literal: true

require 'optparse'
require 'fileutils'
require 'net/http'
require 'uri'
require 'dotenv'

module AdventOfCode
  # Command-line interface module for Advent of Code solutions
  module CLI
    Dotenv.load
    module_function

    def run(year:, day:)
      validate_input!(year, day)
      
      input = fetch_input(year, day)
      solution = load_solution(year, day)
      
      solve_and_print(solution, input)
    end

    def validate_input!(year, day)
      unless (1..25).include?(day)
        raise ArgumentError, "Day must be between 1 and 25, got #{day}"
      end

      raise ArgumentError, "Invalid year" if year < 2015
    end

    def fetch_input(year, day)
        validate_input(year, day)

        session_token = ENV['AOC_SESSION_TOKEN']
        raise RuntimeError, "Advent of Code session token not found. Set AOC_SESSION_TOKEN in .env file." if session_token.nil? || session_token.empty?

        url = URI("https://adventofcode.com/#{year}/day/#{day}/input")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request['Cookie'] = "session=#{session_token}"

        response = http.request(request)

        case response.code
        when '200'
          response.body.chomp  # Remove trailing newline
        when '404'
          raise RuntimeError, "Input not found. Check year, day, and session token."
        when '400', '403'
          raise RuntimeError, "Authentication failed. Verify your session token."
        else
          raise RuntimeError, "Failed to fetch input. HTTP #{response.code}: #{response.body}"
        end
      end
    end

    def load_solution(year, day)
      solution_class_name = "Year#{year}::Day#{format('%02d', day)}"
      Object.const_get(solution_class_name)
    rescue NameError
      raise ArgumentError, "No solution found for Day #{day}, Year #{year}"
    end

    def solve_and_print(solution_class, input)
      puts "=== Part 1 ==="
      part1_result = solution_class.part_1(input)
      puts part1_result

      puts "\n=== Part 2 ==="
      part2_result = solution_class.part_2(input)
      puts part2_result
    end
  end
end
