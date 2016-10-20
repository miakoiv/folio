class Postcode < ApplicationRecord
  self.primary_key = :code

  belongs_to :municipality

  scope :lookup, -> (term) {
    where('code LIKE :term OR town LIKE :term', term: "#{term}%")
  }

  def to_s
    "#{code} #{town}"
  end
end
