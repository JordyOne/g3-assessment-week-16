require 'csv'
require 'time'

def find_highest_average_temp(tsv_file)
  data = averages_by_container(tsv_file)
  highest_temp = data.sort_by { |container, value| value[:temperature] }
  highest_temp[-1][0].to_s
end

def find_highest_water_level(tsv_file)
  data = averages_by_container(tsv_file)
  highest_temp = data.sort_by { |container, value| value[:water_level] }
  highest_temp[-1][0].to_s
end

def find_highest_ph(data)
  data = container_averages_data(data)
  highest_temp = data.sort_by { |container, value| value[:ph] }
  highest_temp[-1][0].to_s
end

def data_within_range(tsv_file, start_date, end_date)
  data = parse_file(tsv_file)
  start_date = convert_to_time(start_date)
  end_date = convert_to_time(end_date)
  data_in_range = []
  data.each do |row|
    time = Time.parse(row[0])
    if time > start_date && time < end_date
      data_in_range << row
    end
  end
  find_highest_ph(data_in_range)
end

def averages_by_container(tsv_file)
  averages= {}
  final = {}
  averages[:container_1] = []
  averages[:container_2] = []
  averages[:container_3] = []
  data = parse_file(tsv_file)
  data.each do |row|
    if row[1] == "container1"
      averages[:container_1] << row
    elsif row[1] == "container2"
      averages[:container_2] << row
    else
      averages[:container_3] << row
    end
  end
  averages.map do |container, value|
    final[container.to_sym] = averages(value)
  end
  final
end

def container_averages_data(data)
  averages= {}
  final = {}
  averages[:container_1] = []
  averages[:container_2] = []
  averages[:container_3] = []
  data = data
  data.each do |row|
    if row[1] == "container1"
      averages[:container_1] << row
    elsif row[1] == "container2"
      averages[:container_2] << row
    else
      averages[:container_3] << row
    end
  end
  averages.map do |container, value|
    final[container.to_sym] = averages(value)
  end
  final
end

def data_averages(tsv_file)
  data = parse_file(tsv_file)
  averages(data)
end


def averages(container)
  averages = {}
  averages[:ph] = average_ph(container).round(2)
  averages[:nutrient_solution] = average_nutrient_solution(container).round(2)
  averages[:temperature] = average_temperature(container).round(2)
  averages[:water_level] = average_water_level(container).round(2)
  averages
end

def parse_file(tsv_file)
  CSV.read(tsv_file, {col_sep: "\t"})
end

def average_ph(data)
  counter = 0
  total = 0
  data.each do |row|
    total += row[2].to_f
    counter += 1
  end
  total/counter
end

def average_nutrient_solution(data)
  counter = 0
  total = 0
  data.each do |row|
    total += row[3].to_f
    counter += 1
  end
  total/counter
end

def average_temperature(data)
  counter = 0
  total = 0
  data.each do |row|
    total += row[4].to_f
    counter += 1
  end
  total/counter
end

def average_water_level(data)
  counter = 0
  total = 0
  data.each do |row|
    total += row[5].to_f
    counter += 1
  end
  total/counter
end

def convert_to_time(time_string)
  time_arr = time_string.split('-')
  Time.new(time_arr[0], time_arr[1], time_arr[2])
end



