# frozen_string_literal: true

class AppFormBuilder < ActionView::Helpers::FormBuilder
  def label(attr, options = {})
    content_tag(:span, class: 'flex gap dark:text-gray-light font-medium') do
      super + required_flag(attr)
    end
  end

  def text_field(attr, options = {})
    super(attr, merge_options_and_class(text_field_classes, options.merge({ required: attr_required?(attr) })))
  end

  def email_field(attr, options = {})
    super(attr, merge_options_and_class(text_field_classes, options.merge({ required: attr_required?(attr) })))
  end

  def password_field(attr, options = {})
    super(attr, merge_options_and_class(text_field_classes, options.merge({ required: attr_required?(attr) })))
  end

  def text_area(attr, options = {})
    super(attr, merge_options_and_class(text_area_classes, options.merge({ required: attr_required?(attr) })))
  end

  def submit(value = nil, options = {})
    super(value, merge_options_and_class(submit_classes, options))
  end

  def form_field(options = {}, &block)
    content_tag(:div, merge_options_and_class('my-5', options), &block)
  end

  private

  def attr_required?(attr)
    @object
      .class
      .validators_on(attr)
      .select { |v| v.is_a?(ActiveRecord::Validations::PresenceValidator) }
      .select { |v| attr_required_selector(v) }
      .size
      .positive?
  end

  def attr_required_selector(val)
    lam = val.options[:if]
    return @object.send(lam) if lam.is_a?(Symbol)
    return @object.instance_exec(&lam) if lam

    lam = val.options[:unless]
    return !@object.send(lam) if lam.is_a?(Symbol)
    return !@object.instance_exec(&lam) if lam

    false
  end

  def required_flag(attr)
    return '' unless attr_required?(attr)

    content_tag(:small) { '*' }
  end

  def text_color_classes
    'text-dark'
  end

  def base_input_class
    # rubocop:disable Layout/LineLength
    "block shadow rounded-md dark:bg-gray-light border border-gray-light outline-none px-3 py-2 w-full focus:ring-accent-dark focus:border-0 #{text_color_classes}"
    # rubocop:enable Layout/LineLength
  end

  def text_area_classes
    base_input_class
  end

  def text_field_classes
    base_input_class
  end

  def submit_classes
    'rounded-lg py-3 px-5 bg-accent-primary text-white inline-block font-medium cursor-pointer disabled:hover:shadow-none hover:shadow disabled:text-white disabled:cursor-default disabled:bg-gray-light'
  end

  def merge_options_and_class(default_classes, options)
    class_name = "#{default_classes} #{options[:class]}".strip
    options.merge({ class: class_name })
  end

  def content_tag(ele, options = {}, &block)
    @template.content_tag(ele, options, &block)
  end
end
