class GamesFinder < BaseFinder
  def query
    byebug
    collection = by_name(model)
    collection
  end

  private

  def default_model
    current_account.games
  end

  def by_name(items)
    return items if params[:name].blank?

    items.where("name ILIKE ?", "%#{params[:name]}%")
  end
end
