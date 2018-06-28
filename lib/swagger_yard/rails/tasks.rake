namespace :swagger do
  task :json, [:filename] => :environment do |t, args|
    File.open(args[:filename] || "swagger.json", "w") do |f|
      f.puts JSON.pretty_generate(SwaggerYard::Swagger.new.to_h)
    end
  end
end

namespace :openapi do
  task :json, [:filename] => :environment do |t, args|
    File.open(args[:filename] || "openapi.json", "w") do |f|
      f.puts JSON.pretty_generate(SwaggerYard::OpenAPI.new.to_h)
    end
  end
end
