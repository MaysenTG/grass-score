class GamesFinder < BaseFinder
  def query
    collection = by_name(model)
    collection
  end

  private

  def default_model
    Game.all
  end

  def by_name(items)
    return items if params[:name].blank?

    items.where("name ILIKE ?", "%#{params[:name]}%")
  end
end
