class BaseFinder
  attr_accessor :params, :model

  def initialize(params: nil, model: nil, builder: nil)
    self.params = remove_nulls(params || {})
    self.model = model || default_model
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
    sorting_key || api_sorting_key || default_sort
  end

  def sorting_key
    return false unless params[:sort].present?
    params[:sort]
  end

  def api_sorting_key
    return false unless params[:sort_by].present?
    params[:sort_by].to_s.concat("_", params[:sort_direction] || "asc")
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
