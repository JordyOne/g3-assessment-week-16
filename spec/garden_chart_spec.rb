require 'spec_helper'
require 'garden_chart'
require 'csv'

describe 'Accepts a file type' do
  it "can read a data source" do
    averages_by_container('data/metrics.tsv')
  end

  it "can find the highest average temp" do
    find_highest_average_temp('data/metrics.tsv')
  end

  it "can find the highest average water_level" do
    find_highest_water_level('data/metrics.tsv')
  end

  it "can find the averages for all data" do
    data_averages('data/metrics.tsv')
  end

  it "can find averages for a date range" do
    data_within_range('data/metrics.tsv', '2013-01-01', '2015-01-01')
  end
end
