require "./Rgbcolorpixel"
require "./Vector3"

class Luz
	attr_accessor :color
	attr_accessor :posicion

	def initialize(color=Rgb_color_pixel.new,posicion=Vector3.new)
		@color=color
		@posicion=posicion
	end
end