class PaginationService
  attr_accessor :classe_name, :query_parameters_hash
  LIMIT_DEFAULT = 8

  def self.process_query(classe_name, query_parameters_hash)
    new(classe_name, query_parameters_hash).execute
  end

  def initialize(classe_name, query_parameters_hash)
    self.classe_name = classe_name
    self.query_parameters_hash = query_parameters_hash
  end

  def execute
    page = query_parameters_hash[:page].to_i - 1
    page =  (page < 0) ? 0 : page

    limit = query_parameters_hash[:limit].to_i
    limit = (limit <= 0) ? LIMIT_DEFAULT : limit

    itens = query_pagination(page, limit)
    { "page": page + 1, "page_size": itens.count, "itens": itens }
  end

  def query_pagination(page, limit)
    classe_name.limit(limit).offset(page * limit)
  end

  def query_pagination_with_filter(page, limit)
  end
end
