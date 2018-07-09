class PagesController < ApplicationController
  before_action :already_login?

  def index
    if params[:search]
      @value = params[:value]
      @pages = Page.includes(:group).where("name like '%#{params[:value]}%'").order(:group_id).page(params[:page])
    elsif params[:update_all]
      redirect_to(pages_path) and return unless params[:ids]
      params[:ids].each do |i|
        page = Page.find i
        page.update "#{params[:type]}": params[:value]
      end
      redirect_to pages_path
    else
      @pages = Page.all.order(:group_id).order(:name).page(params[:page])
    end
  end

  def new
    @page = Page.new
    redirect_to pages_path and return unless (is_admin?)
  end

  def create
    Page.create page_params
    redirect_to pages_path
  end

  def edit
    @page = Page.find_by id: params[:id]
    redirect_to pages_path and return unless (is_admin? || @page.not_code?)
  end

  def update
    page = Page.find_by id: params[:id]
    redirect_to pages_path and return unless (is_admin? || page.not_code?)
    page.update page_params
    redirect_to edit_page_path(page)
  end

  def destroy
    page = Page.find_by id: params[:id]
    redirect_to pages_path and return unless (is_admin? || page.not_code?)
    page.delete
    redirect_to pages_path
  end

  def apply
    page = Page.find params[:id]
    content = page.content
    pages = Page.where(group_id: page.group.id).where("id != #{page.id}")
    pages.each do |p|
      new_content = content.gsub("p#{page.id}", "p#{p.id}");
      new_content = new_content.gsub("#{page.coin}", "#{p.coin}");
      p.update! content: new_content
    end
    redirect_to pages_path
  end

  def trade
    @page = Page.find params[:id]
  end

  def do_trade
    id = params[:id]
    lvc_list = params[:list]
    lvc_profit = params[:profit]
    lvc_lose = params[:lose]

    result = ''
    result += Slot.find_by(key: :variables).value
    result += 'delete $pages;'
    result += 'delete $this;'

    result += '$pages={};'
    pages = Page.where(id: id)
    pages.each do |p|
      content = p.content
      default_function_variables = Slot.where(key: :default_function_variables).first.value
      content = content.gsub('@default_function_variables', default_function_variables)
      auto_change_graph = p.yes? ? 'true' : 'false'
      content = content.gsub('@auto_change_graph', auto_change_graph)
      content = content.gsub('@namePP', p.name)
      content = content.gsub('@lvc_list', lvc_list)
      content = content.gsub('@lvc_profit', lvc_profit)
      content = content.gsub('@lvc_lose', lvc_lose)
      result += "$pages['#{p.name}']={code: #{content}, time: #{p.time}, id: #{p.id}};"
    end

    result += '$this={};'
    Standard.all.each do |c|
      result += "$this['#{c.key}']= #{c.value};"
    end
    result += Slot.find_by(key: :run_loop).value
    @result = {data: result}
  end

  private
  def page_params
    p = if is_admin?
      params.require(:page).permit :id, :name, :description, :coin, :content, :time, :status, :group_id, :chuoi, :ref, :link_ref
    else
      params.require(:page).permit :id, :name, :description, :coin, :time, :content, :chuoi
    end
    p[:status] = :not_code unless p[:status]
    p
  end

  def redirect_if_no_admin
    redirect_to(pages_path) and return unless is_admin?
  end
end
