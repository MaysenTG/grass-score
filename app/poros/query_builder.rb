class QueryBuilder
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def op_query(attr, op, value)
    return nil unless model.attribute_names.include?(attr.to_s)
    return nil unless value.present?
    case op
    when :eq, :lt, :gt, :gteq, :lteq
      model.arel_table[attr.to_sym].send(op, value)
    end
  end
end
