module ApplicationHelper
  def current_page
    params[:page] || 1
  end

  def current_category
    params[:category] || 'news'
  end

  def first_page?
    current_page.to_i == 1
  end

  def previous_page_path
    current_path.merge page: current_page.to_i - 1
  end

  def next_page_path
    current_path.merge page: current_page.to_i + 1
  end

  private

  def current_path
    params.permit(:category, :page).merge category: current_category
  end
end
