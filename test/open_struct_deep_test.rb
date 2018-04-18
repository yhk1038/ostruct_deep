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
           ],
           :holiday => ["New Year's Day", "Thanksgiving Day"]
  }
  
  def test_it_still_run
    puts "\n\n\n"
    puts OpenStructDeep.new DATA
    puts "\n\n\n"
    assert OpenStructDeep.new DATA
  end
  
  def test_initialize_case
    # case 1 : wrapping hash bracket
    hash = {name: 'John Smith', age: 70, pension: 300}
    assert OpenStructDeep.new hash
    
    # case 2 : inline
    assert OpenStructDeep.new(name: 'John Smith', age: 70, pension: 300)
    
    # case 3 : append each data
    person = OpenStructDeep.new
    person.name    = "John Smith"
    person.age     = 70
    person.pension = 300
    assert_equal 70, person.age
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
  
  def test_hash_has_to_ostruct_deep
    # check sample is_a? Hash
    assert_equal Hash, DATA.class
    
    # hash.to_ostruct_deep
    assert_equal OpenStructDeep.new(DATA), DATA.to_ostruct_deep
  end
  
  def test_it_can_rollback_to_h
    # check sample is_a? Hash
    assert_equal Hash, DATA.class

    # ostruct_deep.to_h
    osd = OpenStructDeep.new DATA
    assert_equal DATA.symbolize_keys, osd.to_h
  end
  
  private

  def convert_string_key_to_method osd
    assert_equal 'Joseon', osd.country
  end

  def convert_symbol_key_to_method osd
    assert_equal 20000000, osd.population
  end
end
