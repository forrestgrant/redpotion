class UIViewController
  def append(view_or_constant, style=nil, opts = {})
    self.rmq.append(view_or_constant, style, opts)
  end
  def append!(view_or_constant, style=nil, opts = {})
    self.rmq.append!(view_or_constant, style, opts)
  end

  def prepend(view_or_constant, style=nil, opts = {})
    self.rmq.prepend(view_or_constant, style, opts)
  end
  def prepend!(view_or_constant, style=nil, opts = {})
    self.rmq.prepend!(view_or_constant, style, opts)
  end

  def create(view_or_constant, style=nil, opts = {})
    self.rmq.create(view_or_constant, style, opts)
  end
  def create!(view_or_constant, style=nil, opts = {})
    self.rmq.create!(view_or_constant, style, opts)
  end

  def build(view_or_constant, style = nil, opts = {})
    self.rmq.build(view_or_constant, style, opts)
  end
  def build!(view_or_constant, style = nil, opts = {})
    self.rmq.build!(view_or_constant, style, opts)
  end

  def reapply_styles
    self.rmq.all.reapply_styles
  end

  def color
    self.rmq.color
  end

  def font
    self.rmq.font
  end

  def image
    self.rmq.image
  end

  def stylesheet
    self.rmq.stylesheet
  end

  def stylesheet=(value)
    self.rmq.stylesheet = value
  end

  def self.stylesheet(style_sheet_class)
    @rmq_style_sheet_class = style_sheet_class
  end

  def self.rmq_style_sheet_class
    @rmq_style_sheet_class
  end

  def on_load
  end

  def view_did_load
  end

  alias :originalViewDidLoad :viewDidLoad
  def viewDidLoad
    set_stylesheet

    self.originalViewDidLoad
    unless pm_handles_delegates?
      unless self.class.included_modules.include?(ProMotion::ScreenModule)
        self.view_did_load
      end
      self.on_load
    end
  end

  def view_will_appear(animated)
  end

  def viewWillAppear(animated)
    unless pm_handles_delegates?
      self.view_will_appear(animated)
    end
  end

  def view_did_appear(animated)
  end

  def viewDidAppear(animated)
    unless pm_handles_delegates?
      self.view_did_appear(animated)
    end
  end

  def view_will_disappear(animated)
  end

  def viewWillDisappear(animated)
    unless pm_handles_delegates?
      self.view_will_disappear(animated)
    end
  end

  def view_did_disappear(animated)
  end

  def viewDidDisappear(animated)
    unless pm_handles_delegates?
      self.view_did_disappear(animated)
    end
  end

  def should_rotate(orientation)
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    self.should_rotate(orientation)
  end

  def should_autorotate
    true
  end

  def shouldAutorotate
    self.should_autorotate
  end

  def will_rotate(orientation, duration)
  end

  def willRotateToInterfaceOrientation(orientation, duration:duration)
    self.will_rotate(orientation, duration)
  end

  def on_rotate(orientation)
  end

  def didRotateFromInterfaceOrientation(orientation)
    self.on_rotate orientation
  end

  def will_animate_rotate(orientation, duration)
  end

  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    self.will_animate_rotate(orientation, duration)
  end

  protected

  def set_stylesheet
    if self.class.rmq_style_sheet_class
      self.rmq.stylesheet = self.class.rmq_style_sheet_class
      self.view.rmq.apply_style(:root_view) if self.rmq.stylesheet.respond_to?(:root_view)
    end
  end

  private

  def pm_handles_delegates?
    self.respond_to?(:class_handles_delegates?) && self.class_handles_delegates?
  end
end
