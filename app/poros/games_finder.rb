class GamesFinder
  attr_reader :search_params

  def initialize(params:)
    @search_params = params
  end

  def self.query(params:)
    new(params: params).query
  end

  def query
    model = Game.all
    collection = by_name(model)
    collection
  end

  private

  def by_name(model)
    return model if search_params[:name].blank?

    model.where("name ILIKE ?", "%#{search_params[:name]}%")
  end
end
