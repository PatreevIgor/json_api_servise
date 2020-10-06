class Connection
  def up
    current_env = Sinatra::Application.environment.to_s
    config = YAML.load_file('./config/database.yml')

    PG.connect(dbname:   config[current_env]['database'],
               user:     config[current_env]['username'],
               password: config[current_env]['password'],
               port:     config[current_env]['port'],
               host:     config[current_env]['host'])
  end
end
