require 'csv'

def read_text(file_name)
  File.open(file_name) { |file| file.read }
end

def format_data(file)
  table = CSV.read(file, :headers => [:timestamp, :container_name, :ph, :nsl, :temp, :wl], :col_sep => "\t", :converters => :all)
  table.map do |row|
    row.to_hash
  end
end

def hash_data(file)    
  hash = {}
  format_data(file).each do |row|
    if hash[row[:container_name]]
      hash[row[:container_name]] << [{ph: row[:ph], nsl: row[:nsl], temp: row[:temp], water: row[:wl]}]
    else
      hash[row[:container_name]] = [{ph: row[:ph], nsl: row[:nsl], temp: row[:temp], water: row[:wl]}]
    end
  end
  hash
end

def average_wl(file)
  hash = hash_data(file)
  pp hash
  sum = 0
  counter = 0
  hash.each do |row|
    counter += 1
    sum += row[:wl]
  end
  (sum/counter).round(2)
end