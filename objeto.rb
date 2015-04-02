require './Rgbcolorpixel'
require './Vector3'

class Objeto
	attr_accessor :color_difuso
	attr_accessor :color_especular
	attr_accessor :coef_especular

	def initialize(color_difuso,color_especular,coef_especular)
		@color_difuso=color_difuso
		@color_especular=color_especular
		@coef_especular=coef_especular
	end
end