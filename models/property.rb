require('pg')

class Property

  attr_accessor :address, :year, :beds, :build

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @year = options['year'].to_i
    @beds = options['beds'].to_i
    @build = options['build']
  end


  def save()
    db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
    sql = "INSERT INTO properties
    ( address,
      year,
      beds,
      build
    )
    VALUES
    ($1, $2, $3, $4) RETURNING id"
    values =
    [@address, @year, @beds, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Property.all()
    db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    listings = db.exec_prepared("all")
    db.close()
    return listings.map{ |listing| Property.new(listing) }
  end

  def Property.delete_all()
    db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
    sql = "DELETE FROM properties WHERE id= $1"
    value =[@id]
    db.prepare("delete", sql)
    dp.exec_prepared("delete", value)
    db.close()
  end

  def update()
    db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
    sql = "UPDATE properties
    SET
    (address,
      year,
      beds,
      build
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@address, @year, @beds, @build, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
    end

    def Property.find(id)
      db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
      sql = "SELECT * FROM properties WHERE id = $1"
      value = [id]
      db.prepare("find", sql)
      listings = db.exec_prepared("find", value)[0]
      db.close()
      property = Property.new(listings)
      return property
    end

    def Property.find_by_address(address)
      db = PG.connect( {dbname: 'property_list', host: 'localhost'} )
      sql = "SELECT * FROM properties WHERE address = $1"
      value = [address]
      db.prepare("find_by_address", sql)
      listings = db.exec_prepared("find_by_address", value)[0]
      db.close()
      property = Property.new(listings)
      return property
    end

    end
