# test_quake_log_parser.rb

# Requer o arquivo do parser
require_relative 'config/logs/public/quake/log_game.log'  # Substitua 'config/logs/public/quake/log_game.log' pelo caminho real

# Caminho para o arquivo de log de exemplo
log_file_path = 'config/logs/public/quake/log_game.log'  # Substitua 'path/to/your/log_file.log' pelo caminho real

# Cria uma instância da classe QuakeLogParser
parser = QuakeLogParser.new(log_file_path)

# Chama o método parse_log para analisar o arquivo de log
game_data = parser.parse_log

# Imprime os dados analisados no console
puts game_data
