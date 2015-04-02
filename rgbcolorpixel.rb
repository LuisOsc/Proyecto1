class Rgb_color_pixel

    attr_accessor :a
    attr_accessor :b
    attr_accessor :c

	def initialize(a=0.0,b=0.0,c=0.0)
		@a = a
		@b = b
		@c = c
	end

	def modificar(a,b,c)

		@a = a
		@b = b
		@c = c
	end

	def correccion(ra) 
	  (0..ra.length-1).each do |i|

			if ra[i] > 1.0
				ra[i] = 1
			else
			if ra[i] < 0.0
				ra[i] = 0
			end
		end
		end

		return Rgb_color_pixel.new(ra[0],ra[1],ra[2])

	end

	def suma(a,b,c)
		vec1= []
		r1 = @a + a
		g1 = @b + b
		b1 = @c + c

		vec1<< r1 << g1 << b1

		return correccion(vec1)

		
	end

	def resta(a,b,c)
		vec2= []
		r1 = @a - a
		g1 = @b - b
		b1 = @c - c

		vec2 << r1 << g1 << b1

		return correccion(vec2)
	end

	def producto(a,b,c)
		vec3= []
		r1 = @a * a
		g1 = @b * b
		b1 = @c * c

		vec3<< r1 << g1 << b1

		return correccion(vec3)
	end


	def producto_n_RGB(n)
		vec4= []

		r1 = @a * n
		g1 = @b * n
		b1 = @c * n

		vec4<< r1 << g1 << b1

		return correccion(vec4)
	end

end