# frozen_string_literal: true

require_relative '../module/camel_snake_resolver'
require_relative '../user_interface/console'
# @param none
class Connection
  def initialize(uis_len)
    @uis = []
    uis_len.times { @uis.push Console.new(self) }
    i = 1; @uis.each {|ui| ui.cono = i; i += 1; ui.conop} # rubocop:disable Style/Semicolon TEST
  end

  def select_game(game = :Twentyone)
    definition = [:CardN13S4J0, [:PersonPlayer], [:NpcDealer]]
    require_relative "../game/#{snakeization game}"
    (eval game.to_s).new(definition) # rubocop:disable Security/Eval
  end

  # def pls_assign(selections)
  #   @uis.each { _1.select_assign selections }
  # end

  # def ui_assign(jacker_person, ui)

  # end

  def report(pri_event, pub_event)
    p ""
  end
end

Connection.new(3)
