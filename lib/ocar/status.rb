module Ocar
  class Status

    attr_reader :number, :owner, :description, :date, :location, :type

    def initialize(json)
      @number = json['data'][0]['numeroPieza'].to_s
      @owner = json['data'][0]['titular']
      @description = json['data'][0]['descripcion']
      @date = json['data'][0]['fecha']
      @location = json['data'][0]['sucursal']
      @type = json['data'][0]['tipo']
    end
  end
end
