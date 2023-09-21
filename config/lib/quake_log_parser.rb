require_relative 'config/logs/public/quake/log_game.log'

class QuakeLogParser
  def initialize(log_file_path)
    @log_file_path = log_file_path
  end

  def parse_log
    game_data = {}
    current_game = nil

    File.open(@log_file_path, 'r').each_line do |line|
      case line
      when /InitGame/
        current_game = parse_init_game(line)
        game_data[current_game['game_id']] = current_game
      when /Kill:/
        parse_kill(line, current_game)
      end
    end

    game_data
  end

  private

  def parse_init_game(line)
    game_id = line.match(/InitGame: (\d+)/)[1].to_i
    {
      'game_id' => game_id,
      'total_kills' => 0,
      'players' => [],
      'kills' => {}
    }
  end

  def parse_kill(line, game)
    match = line.match(/Kill: (\d+) (\d+) (\d+): (.+) killed (.+) by (.+)/)
    return unless match

    killer_id, killed_id, means_of_death, killer, killed, means = match.captures
    game['players'] << killer unless game['players'].include?(killer)
    game['players'] << killed unless game['players'].include?(killed)
    game['total_kills'] += 1
    game['kills'][killer] ||= 0
    game['kills'][killer] += 1 unless killer == '<world>'
    game['kills'][killed] ||= 0
    game['kills'][killed] -= 1 unless killed == '<world>'
  end
end
