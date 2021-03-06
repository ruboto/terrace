class Entity
  $window = MrubyJs::get_root_object
  $crafty = $window.Crafty

  def initialize(*components)
    @components = components

    # Convert names into a string list that CraftyJS wants
    # These are the basic/global ones that always apply.
    component_names = '2D, Canvas,'

    @components.each do |c|
      component_names = "#{component_names} #{c.crafty_name}, "
    end

    if component_names.include?('Text') && component_names.include?('Color')
      # These collide. You get a solid block.
      component_names = component_names.sub('Color,', '')
    end

    @me = $crafty.e(component_names)

    @components.each do |c|
      # In CraftyJS, you make calls directly to the entity, not components
      # Set this, so each component can make calls to the entity.
      c.entity = @me
    end
  end
end
