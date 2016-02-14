class Location < ActiveRecord::Base
  has_many :races

  # def as_json(options={})
  #   super(options.merge(except: [:id, :created_at, :updated_at]))
  #   include: [races: {except: [:id, :location_id]}]
  #   :medthods => :links, :message => options[:message]))
  # end
  #
  # def to_xml(options={})
  #   super(options.merge(except: [:id, :created_at, :updated_at]))
  #   include: [races: {except: [:id, :location_id]}]
  # end

  # this is called for both as_json and to_xml
  def serializable_hash (options={})
    options = {
      # declare what we want to show
      only: [:id, :city, :latitude, :longitude],
      include: [races: {only: [:id, :name]}] # includes races
    }.update(options)

    super(options)
  end
end
