require 'sinatra'
require 'json'

# Define a rota padrão
get '/' do
  erb :index
end

# Define a rota para lidar com as solicitações do formulário
post '/data' do
  # Obtenha o ID fornecido pelo usuário
  id = params[:id]

  # Leia o arquivo JSON
  file = File.read('../src/files/data.json')
  data = JSON.parse(file)

  # Procure o objeto com o ID fornecido
  object = data.find { |obj| obj['id'] == id.to_i }

  # Retorne um erro 404 se o objeto não for encontrado
  halt 404, 'Object not found' unless object

  # Renderize o template de exibição com os dados do objeto
  erb :data, locals: { object: object }
end