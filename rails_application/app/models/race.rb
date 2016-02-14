class Race < ActiveRecord::Base
  # Associations
  belongs_to :race_creator
  belongs_to :location

  # Validation
  validates :race_creator_id, presence: true
  validates :location_id, presence: true

  # this is called for both as_json and to_xml
  def serializable_hash (options={})
    options = {
      # declare what we want to show
      only: [:name, :date, :organiser, :web_site, :distance]
    }.update(options)

    super(options)
  end
end
