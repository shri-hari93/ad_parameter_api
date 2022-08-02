# frozen_string_literal: true

require "./lib/ad_parameter"

task :ad_parameter_task do
  desc "populate ad parameters to protobuf"
  paths = Dir["dashboard_configurations/*.xml"]
  paths.lazy.map { |file_path| File.read(file_path) }.each do |configuration|
    ad_parameter = AdParameter.new(configuration)
    puts ad_parameter.serialize
  end
end
