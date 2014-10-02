require 'spec_helper'
require 'garden_chart'
require 'csv'

describe 'Accepts a file type' do
  def read_file(file_name)
   File.open(file_name, "r") { |file| file.read }
  end

  it "Accepts a file type" do
    expect(read_text('data/metrics.tsv')).to eq(read_file('data/metrics.tsv'))
  end

  it "can iterate through file" do
    expect(format_data('data/metrics.tsv').first[:container_name]).to eq('container1')
  end

  it "can output the average water level" do
    expect(average_wl('data/metrics.tsv')).to eq(2.12)
  end

end
