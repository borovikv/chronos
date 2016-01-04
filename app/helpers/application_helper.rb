module ApplicationHelper
  def div_with_error_class_if(condition, attributes = {}, &block)

    if condition
      div_class = attributes[:class]
      attributes[:class] = (div_class && (div_class + ' ') || '') + 'has-error'
    end
    content_tag('div', attributes, &block)
  end
end
