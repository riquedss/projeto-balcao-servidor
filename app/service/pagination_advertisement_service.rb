class PaginationAdvertisementService
  attr_accessor :classe_name, :query_parameters_hash, :query
  LIMIT_DEFAULT = 8
  EXPECTED_FILTERS = %w[scope type category campus min_price max_price min_date max_date]

  def self.process_query(classe_name, query_parameters_hash)
    new(classe_name, query_parameters_hash).execute
  end

  def initialize(classe_name, query_parameters_hash)
    self.classe_name = classe_name
    self.query = classe_name
    self.query_parameters_hash = query_parameters_hash
  end

  def execute
    page = query_parameters_hash[:page].to_i - 1
    page =  (page < 0) ? 0 : page

    limit = query_parameters_hash[:limit].to_i
    limit = (limit <= 0) ? LIMIT_DEFAULT : limit

    query_filter if query_has_filter?
    query_pagination(page, limit)

    { "page": page + 1, "page_size": query.count, "itens": query }
  end

  def query_pagination(page, limit)
    self.query = query.limit(limit).offset(page * limit)
  end

  def query_filter
    self.query = query.filter_statuses(query_parameters_hash["scope"]) unless query_parameters_hash["scope"].blank?
    self.query = query.filter_kinds(query_parameters_hash["type"]) unless query_parameters_hash["type"].blank?
    self.query = query.filter_categories(query_parameters_hash["category"]) unless query_parameters_hash["category"].blank?
    self.query = query.filter_campus(query_parameters_hash["campus"]) unless query_parameters_hash["campus"].blank?
    self.query = query.filter_price(query_parameters_hash["min_price"], query_parameters_hash["max_price"]) unless query_parameters_hash["min_price"].blank?
    self.query = query.filter_date(query_parameters_hash["min_date"], query_parameters_hash["max_date"]) if !query_parameters_hash["min_date"].blank? && dates_valid?
  end

  private

  def query_has_filter?
    keys_query = query_parameters_hash.keys
    return false if keys_query.blank?

    EXPECTED_FILTERS.each do |key_filter|
      return true if keys_query.include?(key_filter)
    end

    false
  end

  def dates_valid?
    return false unless classe_name.date_valid?(query_parameters_hash["min_date"])

    return true if query_parameters_hash["max_date"].blank?

    classe_name.date_valid?(query_parameters_hash["max_date"])
  end
end
