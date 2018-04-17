require "test_helper"

class OpenStructDeepTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::OpenStructExtend::VERSION
  end
  
  def test_that_it_can_load_ostruct
    assert OpenStruct
  end

  DATA = { "country" => "Joseon",
           :population => 20000000,
           :info => {
             from: 1392,
             to: 1910,
             started_by: {
               name: "Lee Seong Gye"
             }
           },
           :kings => [
             { :name => "SeJong",
               :terms => {
                 :from => 1418,
                 :to => 1450
               }
             },
             { :name => "JeongJo",
               :info => {
                 :what => "ever"
               }
             }
           ]
  }
  
  def test_initialize_case
    assert OpenStructDeep.new DATA
  end
  
  def test_it_makes_method_from_key
    osd = OpenStructDeep.new DATA
    
    convert_string_key_to_method osd
    convert_symbol_key_to_method osd
  end
  
  def test_it_works_on_deep_floor
    osd = OpenStructDeep.new DATA
    
    # first_floor
    assert_equal 'Joseon', osd.country
    # second_floor
    assert_equal 1392, osd.info.from
    # third_floor
    assert_equal 'Lee Seong Gye', osd.info.started_by.name
  end
  
  private

  def convert_string_key_to_method osd
    assert_equal 'Joseon', osd.country
  end

  def convert_symbol_key_to_method osd
    assert_equal 20000000, osd.population
  end
end
