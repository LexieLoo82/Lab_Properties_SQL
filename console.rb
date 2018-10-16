require('pry-byebug')
require_relative('models/property')

Property.delete_all()

property1 = Property.new(
  {
    'address' => '1 High St',
    'year' => '1995',
    'beds' => '3',
    'build' => 'flat'
  }
)
property2 = Property.new(
  {
    'address' => '1 Spade St',
    'year' => '1725',
    'beds' => '1',
    'build' => 'house'
  }
)
property3 = Property.new(
  {
    'address' => '3 Green St',
    'year' => '1985',
    'beds' => '5',
    'build' => 'house'
  }
)
property1.save()
property2.save()
property3.save()

# found_property = Property.find(1)
found_property = Property.find_by_address('1 Spade St')

# p Property.find(1)

# listings = Property.find(1)

binding.pry
nil
