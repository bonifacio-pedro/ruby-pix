# frozen_string_literal: true

require_relative '../db/database'
require_relative 'actions'
require 'cpf_utils'

# Insert, verify and search
class Pix
  include Database

  def self.insert_data_new_pix(username, key_type, key)
    # Verify DB
    return 'Key already registered' unless Query.search_pix(key).zero?

    if verify_key(key_type, key)
      Query.insert_new_pix(username, key_type, key)
      puts "#{username} pix successfully added to the database!"
    else
      puts 'We had an error adding the key, please check if key type and key is valid and try again!'
    end
  end

  # Verify if key is valid
  def self.verify_key(key_type, key)
    case key_type
    when 'EMAIL'
      return true if key =~ EMAIL_REGEX
    when 'CPF'
      return true if CpfUtils.valid_cpf?(key)
    when 'CELL'
      return true
    end
    false
  end

  # Search key with your initial
  def self.search_key_initial(initial)
    search = Query.search_pix_partial_key(initial)
    return 'No records begin with this combination' if search.empty?

    Actions::generate_table(%w[Id Username Key-type Key], search)
  end
end
