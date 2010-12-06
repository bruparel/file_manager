class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field collection_select select date_select password_field text_area file_field].each do |method_name|
    define_method(method_name) do |field_name, *args|
      @template.content_tag(:p, field_label(field_name, *args) + "<br />".html_safe  + super(field_name, *args))
    end
  end

  def check_box(field_name, *args)
    @template.content_tag(:p, super + " " + field_label(field_name, *args))
  end

  def submit(label = "Submit", options = {})
    submit = super(label)
    submit += " or #{@template.link_to 'cancel', options[:cancel]}".html_safe if options[:cancel]
    @template.content_tag(:p, submit)
  end

  def many_check_boxes(name, subobjects, id_method, name_method, options = {})
    @template.content_tag(:p) do
      field_name = "#{object_name}[#{name}][]"
      subobjects.map do |subobject|
        @template.check_box_tag(field_name, subobject.send(id_method), object.send(name).include?(subobject.send(id_method))) + " " + subobject.send(name_method)
      end.join("<br />") + @template.hidden_field_tag(field_name, "")
    end
  end

  def error_messages(*args)
    @template.render_error_messages(object, *args)
  end

  private

  def field_label(field_name, *args)
    options = args.extract_options!
    options.reverse_merge!(:required => field_required?(field_name))
    options[:label_class] = "required" if options[:required]
    t_label = options.delete(:label)
    t_label = (t_label.nil? ? field_name.to_s.humanize.titleize : t_label)
    if object.errors[field_name].any?
      temp_label = t_label + ": " +
        # @template.content_tag(:span, ([object.errors.on(field_name)].flatten.first.sub(/^\^/, '')), :class => 'error_message')
        @template.content_tag(:span, ([object.errors[field_name]].flatten.first.sub(/^\^/, '')), :class => 'error_message')
    else
      temp_label = t_label
    end
    label(field_name, temp_label.html_safe, :class => options[:label_class])
  end

  def field_required?(field_name)
    object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
  end

  def objectify_options(options)
    super.except(:label, :required, :label_class)
  end
end
