module ApplicationHelper
  include Pagy::Frontend
  include BetterHtml::Helpers

  # Public: Pick the correct arguments for form_for when shallow routes are used.
  # parent - The Resource that has_* child
  # child - The Resource that belongs_to parent.
  #
  # in _form.html.erb you can use
  # form_for shallow_args(@post, @comment) do |f|
  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end
end
