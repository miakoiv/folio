require 'searchlight/adapters/action_view'

class CustomerSearch < Searchlight::Search
  include Searchlight::Adapters::ActionView

  def base_query
    Customer.includes(:person)
  end

  def search_unit
    query.where(unit: unit)
  end

  def search_since_date
    query.where(Customer.table[:started_at].gteq(since_date))
  end

  def search_until_date
    query.where(Customer.table[:started_at].lt(until_date))
  end

  def search_contacts
    query.left_outer_joins(:contacts).where(users: {id: contacts})
  end
end
