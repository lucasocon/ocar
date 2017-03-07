require 'test_helper'

class OcarTest < Minitest::Test
  def setup
    @fake_response = %{
      {"success":true,"data":[{"code":"1808200000001055401","log":[{"date":"21-12-2011","description":"Procesado en OCA - PLANTA VELEZ SARSFIELD"},{"date":"23-12-2011","description":"En viaje a Sucursal de Destino - PLANTA VELEZ SARSFIELD"},{"date":"24-12-2011","description":"En viaje a Sucursal de Destino - PLANTA VELEZ SARSFIELD"},{"date":"27-12-2011","description":"En Tr\u00e1nsito a Suc. de Destino - CATAMARCA "},{"date":"27-12-2011","description":"Programado para visita a domicilio - CATAMARCA "},{"date":"27-12-2011","description":"En Espera de Retiro en Suc. Destino - CATAMARCA "},{"date":"27-12-2011","description"
      :"No entregado (En Stock CI) - CATAMARCA "},{"date":"27-12-2011","description":"Reprogramado para nueva visita - CATAMARCA "},{"date":"27-12-2011","description":"Programado para visita a domicilio - CATAMARCA "},{"date":"27-12-2011","description":"En Espera de Retiro en Suc. Destino - CATAMARCA "},{"date":"27-12-2011","description":"Entregado - CATAMARCA "},{"date":"27-12-2011","description":"Entregado - CATAMARCA "
      }],"detail":[{"IdPieza":"47527323","NumeroEnvio":"1808200000001055401","Remito":{},"CantidadPaquetes"
      :"1","DomicilioRetiro":"MONTIEL                       ","NumeroRetiro":"168  ","PisoRetiro":{"0":"      "},"DeptoRetiro":{"0":"    "},"LocalidadRetiro":"Bs As                    ","CodigoPostalRetiro":"1408    ","Apellido":"VARELA","Nombre":"GABRIEL COBO","Calle":"San Mart\u00edn","Numero":"1069 ","Piso":{"0":"      "},"Depto":{"0":"    "},"Localidad":"SAN FDO.D.VALLE CATAMARCA","Provincia":"Catamarca"
      ,"CodigoPostal":"4700    "}]}]}
    }
    @fake_response_not_found = '{"success":false,"data":{"message":"Not found."}}'
    Typhoeus::Expectation.clear
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ocar::VERSION
  end

  def test_it_gets_a_valid_response
    # mocking each Ocar::TYPES request, one of them with useful data
    Typhoeus.stub('http://www.oca.com.ar').and_return([
      Typhoeus::Response.new(body: @fake_response_not_found),
      Typhoeus::Response.new(body: @fake_response),
      Typhoeus::Response.new(body: @fake_response_not_found),
      Typhoeus::Response.new(body: @fake_response_not_found)
    ])

    expected_response = { "success"=>true, "data"=>[{
      "code"=>"1808200000001055401", "log"=>[
        {"date"=>"21-12-2011", "description"=>"Procesado en OCA - PLANTA VELEZ SARSFIELD"},
        {"date"=>"23-12-2011", "description"=>"En viaje a Sucursal de Destino - PLANTA VELEZ SARSFIELD"},
        {"date"=>"24-12-2011", "description"=>"En viaje a Sucursal de Destino - PLANTA VELEZ SARSFIELD"},
        {"date"=>"27-12-2011", "description"=>"En Tránsito a Suc. de Destino - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"Programado para visita a domicilio - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"En Espera de Retiro en Suc. Destino - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"No entregado (En Stock CI) - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"Reprogramado para nueva visita - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"Programado para visita a domicilio - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"En Espera de Retiro en Suc. Destino - CATAMARCA "},
        {"date"=>"27-12-2011", "description"=>"Entregado - CATAMARCA "}, {"date"=>"27-12-2011",
          "description"=>"Entregado - CATAMARCA "}],
        "detail"=>[{"IdPieza"=>"47527323", "NumeroEnvio"=>"1808200000001055401",
        "Remito"=>{}, "CantidadPaquetes"=>"1", "DomicilioRetiro"=>"MONTIEL                       ",
        "NumeroRetiro"=>"168  ", "PisoRetiro"=>{"0"=>"      "},
        "DeptoRetiro"=>{"0"=>"    "}, "LocalidadRetiro"=>"Bs As                    ",
        "CodigoPostalRetiro"=>"1408    ", "Apellido"=>"VARELA",
        "Nombre"=>"GABRIEL COBO", "Calle"=>"San Martín",
        "Numero"=>"1069 ", "Piso"=>{"0"=>"      "}, "Depto"=>{"0"=>"    "},
        "Localidad"=>"SAN FDO.D.VALLE CATAMARCA",
        "Provincia"=>"Catamarca", "CodigoPostal"=>"4700    "
    }]}]}

    p Ocar.get_package(9808200000001055401).inspect
    assert_equal [expected_response], Ocar.get_package(9808200000001055401)
  end

  def test_it_gets_an_empty_response
    Typhoeus.stub('http://www.oca.com.ar').and_return(
      Typhoeus::Response.new(body: @fake_response_not_found))

    assert_equal [], Ocar.get_package(9808200000001055401)
  end
end
