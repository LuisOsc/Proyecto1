class Vector3

    attr_accessor :a
    attr_accessor :b
    attr_accessor :c

   def initialize(a=0.0,b=0.0,c=0.0)
		@a=a
		@b=b
		@c=c
   end

	def suma(vector)
		return Vector3.new(@a+vector.a,@b+vector.b,@c+vector.c)
	end

	def resta(vector)
		return Vector3.new(@a-vector.a,@b-vector.b,@c-vector.c)
	end

	def producto_vectorial(vector)
       return Vector3.new((@b*vector.c - @c*vector.b),-1 *(@a*vector.c - @c*vector.a),(@a*vector.b - @b*vector.a))
	end

	def producto_escalar(vector)
       return ( (@a*vector.a) + (@b*vector.b) + (@c*vector.c) )
	end

	def modulo()
		var = (@a**2) + (@b**2) + (@c**2)
		return Math.sqrt(var)
	end

	def produc_valor_vector(val)

		x = @a*val
		y = @b*val
		z = @c*val
		return Vector3.new(x,y,z)

	end

end