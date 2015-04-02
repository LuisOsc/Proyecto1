class Vector2

	attr_accessor :a
	attr_accessor :b

	def initialize(a=0.0,b=0.0)
		@a=a
		@b=b
	end

	def suma(a,b)
		return Vector2.new(@a+a,@b+b)
	end

	def resta(a,b)
		return Vector2.new(@a-a,@b-b)
	end

	def producto_vectorial(a,b)
		a = @a * b
		b = a * @b
		return Vector2.new(a,b)
	end

	def producto_escalar(a,b)
        return (modulo(@a,@b) * modulo(a,b)) * (Math::cos(Math::PI*alfa/180))
	end

	def modulo(a,b,c)
        return Math.sqrt( (a*a) + (b*b))
	end
	
end