module Ocar
  class Status

    attr_reader :number, :owner, :description, :date, :location, :type

    def initialize(json)
      @number = json['data']['numeroPieza']
      @owner = json['data']['titular']
      @description = json['data']['descripcion']
      @date = json['data']['fecha']
      @location = json['data']['sucursal']
      @type = json['data']['tipo']
    end
  end
end
