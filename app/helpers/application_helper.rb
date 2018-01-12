module ApplicationHelper
  def current_page
    (params[:page] || 1).to_i
  end

  def first_page?
    current_page == 1
  end

  def previous_page_path
    page_params.merge page: current_page - 1
  end

  def next_page_path
    page_params.merge page: current_page + 1
  end

  private

  def page_params
    params.permit(:page)
  end
end
