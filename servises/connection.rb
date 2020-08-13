class Connection < Sinatra::Base
  def self.to_db
    config = YAML.load_file('./config/database.yml')
    if settings.test?
      PG.connect(dbname: config['test']['database'],
                 user: config['test']['username'],
                 password: config['test']['password'],
                 port: config['test']['port'],
                 host: config['test']['host'])
    else
      PG.connect(dbname: config['development']['database'],
                 user: config['development']['username'],
                 password: config['development']['password'],
                 port: config['development']['port'],
                 host: config['development']['host'])
    end
  end
end
