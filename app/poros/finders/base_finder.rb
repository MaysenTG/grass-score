class BaseFinder
  attr_accessor :params, :model, :current_account

  def initialize(params: nil, model: nil, builder: nil, current_account: nil)
    self.params = remove_nulls(params || {})
    self.model = model || default_model
    self.current_account = current_account
    @builder = builder || QueryBuilder
  end

  def self.query(**kwargs)
    new(**kwargs).query
  end

  private

  attr_reader :builder

  def default_model
    Object.new
  end

  def sorting?
    [:sort, :sort_by].any? { |k| params.key?(k) }
  end

  def sort_key(default_sort = "created_asc")
    return default_sort unless sorting?
    sorting_key || default_sort
  end

  def sorting_key
    return false unless params[:sort].present?
    params[:sort]
  end

  def op_query(attr, op, value)
    @builder.new(model).op_query(attr, op, value)
  end

  def table_name
    model.table_name
  end

  def remove_nulls(parameters)
    parameters.to_enum.to_h.filter { |_k, v| v != "null" }.with_indifferent_access
  end
end
