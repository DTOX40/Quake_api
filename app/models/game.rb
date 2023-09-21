class Game < ApplicationRecord
  serialize :players, Array
  serialize :kills, Hash
end
