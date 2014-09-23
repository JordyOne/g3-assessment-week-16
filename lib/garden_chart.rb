require 'csv'

def read_text(file_name)
  string = File.open(file_name) { |file| file.read }
end

def format_data(file)
  table = CSV.read(file, :headers => [:timestamp, :container_name, :ph, :nsl, :temp, :wl], :col_sep => "\t", :converters => :all)

  hashes = table.map do |row|
    row.to_hash
  end
  hashes
end

def average_data(file)
  hash = {}
  format_data(file).each do |row|
    if hash[:container_name]
      hash[:container_name] << {ph: row[:ph], nsl: row[:nsl], temp: row[:temp], water: row[:wl]}
    else
      hash = {row[:container_name] => {ph: row[:ph], nsl: row[:nsl], temp: row[:temp], water: row[:wl]}}
    end
  end
  puts hash
end