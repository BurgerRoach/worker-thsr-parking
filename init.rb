%w[config worker].each do |folder|
  require_relative "#{folder}/init"
end