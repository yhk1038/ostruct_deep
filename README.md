# OpenStructDeep
[![Gem Version](https://badge.fury.io/rb/ostruct_deep.png)](https://badge.fury.io/rb/ostruct_deep)
[![Build Status](https://travis-ci.org/yhk1038/ostruct_deep.svg?branch=master)](https://travis-ci.org/yhk1038/ostruct_deep)

Make deeper ostruct, such as method chain of javascript object

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ostruct_deep'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ostruct_deep

## Usage
```ruby
require 'ostruct_deep'
 
# Put your hash structure for the first parameter
hash = {name: "John Smith", age: 70, pension: 300}
person = OpenStructDeep.new(hash)
 
 or
 
# It works also
person = OpenStructDeep.new(name: "John Smith", age: 70, pension: 300)
 
 or
 
# Another way you can
person = OpenStructDeep.new
person.name    = "John Smith"
person.age     = 70
person.pension = 300
 
 then
 
puts person.name     # -> "John Smith"
puts person.age      # -> 70
puts person.address  # -> nil
```

#### <Hash obj>.to_ostruct_deep
- return :  object of OpenStructDeep
```ruby
hash = {name: "John Smith", age: 70, pension: 300, friends: ["Pablov", "Harry", "Peter"]}
hash.to_ostruct_deep  # -> <OpenStructDeep name="John Smith", age=70, pension=300, friends=["Pablov", "Harry", "Peter"]>
```

#### <OpenStructDeep obj>.to_h
- return :  object of hash
```ruby
hash = {name: "John Smith", age: 70, pension: 300, friends: ["Pablov", "Harry", "Peter"]}
osd = OpenStructDeep.new(hash)  # -> <OpenStructDeep name="John Smith", age=70, pension=300, friends=["Pablov", "Harry", "Peter"]>
osd.to_h  # -> {:name=>"John Smith", :age=>70, :pension=>300, :friends=>["Pablov", "Harry", "Peter"]}
```

## What's new?
### Originals Problem in (OpenStructure)
In original ostruct (rubysl-ostruct) do below:

```ruby
hash = { "country" => "Australia", :population => 20_000_000, :info => { from: 1392, to: 1910 } }
data = OpenStruct.new(hash)
 
p data        # -> <OpenStruct country="Australia" population=20000000, info={:from=>1392, :to=>1910}>
p data.country # -> "Australia"
p data["country"] # -> "Australia" # still works.
 
p data.info # -> {:from=>1392, :to=>1910}
 
# Problem Case
p data.info.from # -> NoMethodError: undefined method `from' for {:from=>1392, :to=>1910}:Hash
```

### Solved in new one (OpenStructureDeep)
In ostruct_deep do below:

#### Sample Structure
The new hash has many stage and includes array.
```ruby
hash = 
{ "country" => "Joseon",
   :population => 20000000,
   
   :info => { # 2nd stage
     :from => 1392,
     :to => 1910,
     
     :started_by => { # 3rd stage
       name: "Lee Seong Gye"
     }
   },
   
   # Array container
   :kings => [
     { :name => "SeJong",
       :terms => { # 2nd stage in array element
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
```

#### Works
OpenStructDeep works fine :
```ruby
data = OpenStructDeep.new(hash)

p data          # -> <OpenStructDeep country="Joseon", population=20000000, info=#<OpenStructDeep from=1392, to=1910, started_by=#<OpenStructDeep name="Lee Seong Gye">>, kings=[#<OpenStructDeep name="SeJong", terms=#<OpenStructDeep from=1418, to=1450>>, #<OpenStructDeep name="JeongJo", info=#<OpenStructDeep what="ever">>]>
p data.country              # -> 'Joseon'
p data.info                 # -> <OpenStructDeep from=1392, to=1910, started_by=#<OpenStructDeep name="Lee Seong Gye">>
p data.info.started_by.name # -> 'Lee Seong Gye'
 
p data.kings    # -> [#<OpenStructDeep name="SeJong", terms=#<OpenStructDeep from=1418, to=1450>>, #<OpenStructDeep name="JeongJo", info=#<OpenStructDeep what="ever">>]
p data.kings.is_a?(Array)   # -> true
 
# ... you can parse structure whatever you want

```

## Contributing

Bug reports and pull requests are welcome on GitHub at [Repository](https://github.com/yhk1038/ostruct_deep). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

You can contribute in works below with opening issues or pull requests.
- Better Documentation
- Suggest features
- Modify code style
- And more better correct comments

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OpenStructExtend project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ostruct_deep/blob/master/CODE_OF_CONDUCT.md).
