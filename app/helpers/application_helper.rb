# frozen_string_literal: true

module ApplicationHelper

  def runtime_format(runtime)
    hours = (runtime / 60).to_s
    minutes = (runtime % 60).to_s

    "#{hours}hr #{minutes}min"
  end
end
