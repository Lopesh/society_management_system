class SidebarPresenter
  def initialize(view_context)
    @view = view_context
  end
  
  def is_active?(option)
    @view.controller_name == option ? 'active' : ''
  end
end
  